import 'package:easy_localization/easy_localization.dart';
import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:juding/di/service_locator.dart';
import 'package:juding/presentation/registerwallet/pin/pincodeconfirm/cubit/pin_code_confirm_bloc.dart';
import 'package:juding/presentation/registerwallet/pin/pincodeconfirm/cubit/pin_code_confirm_state.dart';
import 'package:pinput/pinput.dart';
import '../../../commonwidgets/common_widgets.dart';
import '../../model/arguments.dart';
import 'cubit/pin_code_confirm_event.dart';

class PinCodeConfirmScreen extends StatelessWidget {
  PinCodeConfirmScreen({super.key});

  final PinCodeConfirmBloc bloc = serviceLocator<PinCodeConfirmBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PinCodeConfirmBloc>(
      create: (_) => bloc,
      child: Scaffold(
        appBar: NftAppBar(
          appBarTitle: 'pin_code_confirm_screen.title'.tr(),
        ),
        body: const Center(
          child: FilledRoundedPinPut(),
        ),
      ),
    );
  }
}

class FilledRoundedPinPut extends StatefulWidget {
  const FilledRoundedPinPut({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FilledRoundedPinPutState();
}

class _FilledRoundedPinPutState extends State<FilledRoundedPinPut> {
  final controller = TextEditingController();
  final focusNode = FocusNode();

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    RouteSettings? settings = ModalRoute.of(context)?.settings;
    final Arguments? arguments = (settings?.arguments) as Arguments?;

    const length = 6;
    const borderColor = Color.fromRGBO(114, 178, 238, 1);
    const fillColor = Color.fromRGBO(222, 231, 240, .57);
    final defaultPinTheme = PinTheme(
      width: 25,
      height: 25,
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.transparent),
      ),
    );

    return BlocConsumer<PinCodeConfirmBloc, PinCodeConfirmState>(
      builder: (_, state) => SizedBox(
        height: 60,
        child: Pinput(
          length: length,
          controller: controller,
          focusNode: focusNode,
          defaultPinTheme: defaultPinTheme,
          obscureText: true,
          obscuringWidget: Container(
            decoration: const BoxDecoration(color: borderColor, shape: BoxShape.circle),
          ),
          validator: (value) {
            BlocProvider.of<PinCodeConfirmBloc>(context)
                .add(PinCodeCheckingEvent(
              pinCodeEntered: arguments!.pin,
              pinCodeConfirmed: value!,
              seed: arguments.words,
            ));
            return null;
          },
        ),
      ),
      listener: (context, state) {
        if (state is ValidPinCodeState) {
          Navigator.pushNamedAndRemoveUntil(context, '/pinCodeConfirmSuccess', (r) => false);
        } else if (state is InvalidPinCodeState) {
          controller.clear();
          showFlashAboutInvalidSeed();
        }
      },
    );
  }

  void showFlashAboutInvalidSeed() {
    context.showFlash<bool>(
      duration: const Duration(seconds: 2),
      builder: (context, controller) => FlashBar(
        controller: controller,
        position: FlashPosition.top,
        content: Card(
          margin: const EdgeInsets.only(left: 8, right: 8, top: 12),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text('pin_code_confirm_screen.invalid_password'.tr(),
                style: const TextStyle(fontSize: 18)),
          ),
        ),
      ),
    );
  }
}
