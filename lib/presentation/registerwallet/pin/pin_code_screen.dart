import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:pinput/pinput.dart';

import '../../commonwidgets/common_widgets.dart';
import '../model/arguments.dart';

class PinCodeScreen extends StatelessWidget {
  const PinCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NftAppBar(
        appBarTitle: 'pin_code_screen.title'.tr(),
      ),
      body: const Center(
        child: FilledRoundedPinPut(),
      ),
    );
  }
}

class FilledRoundedPinPut extends StatefulWidget {
  const FilledRoundedPinPut({Key? key}) : super(key: key);

  @override
  _FilledRoundedPinPutState createState() => _FilledRoundedPinPutState();
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

    RouteSettings? settings = ModalRoute.of(context)?.settings;
    String words = (settings!.arguments) as String;

    return SizedBox(
      height: 60,
      child: Pinput(
        length: length,
        controller: controller,
        focusNode: focusNode,
        defaultPinTheme: defaultPinTheme,
        obscureText: true,
        obscuringWidget: Container(
          decoration:
              const BoxDecoration(color: borderColor, shape: BoxShape.circle),
        ),
        onChanged: (value) {
          if (value.length == length) {
            Navigator.pushNamed(context,
                '/twentyWords/twentyWordsConfirm/pinCode/pinCodeConfirm',
                arguments: Arguments(pin: controller.text, words: words));
          }
        },
      ),
    );
  }
}
