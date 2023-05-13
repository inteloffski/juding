import 'package:easy_localization/easy_localization.dart';
import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:juding/di/service_locator.dart';
import 'package:juding/presentation/registerwallet/twentywordsconfirm/bloc/seed_confirm_state.dart';
import '../../commonwidgets/common_widgets.dart';
import 'bloc/seed_confirm_bloc.dart';
import 'bloc/seed_confirm_event.dart';

class TwentyWordsConfirmScreen extends StatefulWidget {
  const TwentyWordsConfirmScreen({super.key});

  @override
  State<StatefulWidget> createState() => _TwentyWordsConfirmState();
}

class _TwentyWordsConfirmState extends State<TwentyWordsConfirmScreen> {
  final List<TextEditingController> _controllers =
      List.generate(12, (i) => TextEditingController());

  final List<GlobalKey<FormState>> _formKey =
      List.generate(12, (i) => GlobalKey<FormState>());

  List<String>? words;

  @override
  void dispose() {
    for (var element in _controllers) {
      element.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    RouteSettings? settings = ModalRoute.of(context)?.settings;
    words = (settings!.arguments) as List<String>?;
    final SeedConfirmBloc bloc = serviceLocator<SeedConfirmBloc>();

    return BlocProvider<SeedConfirmBloc>(
      create: (_) => bloc,
      child: Scaffold(
        appBar:
            NftAppBar(appBarTitle: 'generate_seed_confirm_screen.title'.tr()),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Text(
                'generate_seed_confirm_screen.subtitle'.tr(),
                style: const TextStyle(
                    fontSize: 14.0, fontStyle: FontStyle.normal),
                textAlign: TextAlign.start,
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: words?.length,
                itemBuilder: (context, index) => ListTile(
                  title: Center(
                    child: Form(
                      key: _formKey[index],
                      child: TextFormField(
                        controller: _controllers[index],
                        decoration: InputDecoration(
                            labelText: "${index + 1}",
                            isDense: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            contentPadding: const EdgeInsets.all(12)),
                      ),
                    ),
                  ),
                  //children: [
                  //  ],
                ),
              ),
            ),
            BlocConsumer<SeedConfirmBloc, StateSeed>(
              builder: (_, state) => Padding(
                padding: const EdgeInsets.only(
                    bottom: 12.0, left: 16.0, right: 16.0),
                child: NftButton(
                  textButton: 'next_button'.tr(),
                  width: double.infinity,
                  onPressed: () {
                    List<String> inputWords = _controllers
                        .map((contoller) => contoller.text.trim())
                        .map((e) => e.replaceAll(',', ''))
                        .toList();

                    bloc.add(CheckingSeedEvent(
                        seedEntered: words!, seedPass: inputWords));
                  },
                ),
              ),
              listener: (context, state) {
                if(state is ValidSeedState){
                  navigateTo();
                } else if(state is InvalidSeedState) {
                  showFlashAboutInvalidSeed();
                }
              },
            ),
          ],
        ),
      ),
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
            child: Text('generate_seed_confirm_screen.invalid_sid'.tr(),
                style: const TextStyle(fontSize: 18)),
          ),
        ),
      ),
    );
  }

  void navigateTo() {
    Navigator.pushNamed(context, "/twentyWords/twentyWordsConfirm/pinCode",
        arguments: words?.join(' '));
  }
}
