import 'package:easy_localization/easy_localization.dart';
import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:juding/di/service_locator.dart';
import 'package:juding/presentation/restorewallet/bloc/restore_waller_state.dart';
import '../commonwidgets/common_widgets.dart';
import 'bloc/restore_wallet_bloc.dart';
import 'bloc/restore_wallet_event.dart';

class RestoreScreen extends StatefulWidget {
  const RestoreScreen({super.key});

  @override
  State<StatefulWidget> createState() => _RestoreState();
}

class _RestoreState extends State<RestoreScreen> {
  final List<TextEditingController> _controllers =
      List.generate(12, (i) => TextEditingController());

  final List<GlobalKey<FormState>> _formKey =
      List.generate(12, (i) => GlobalKey<FormState>());

  final RestoreWalletBloc bloc = serviceLocator();

  @override
  void dispose() {
    for (var element in _controllers) {
      element.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => bloc,
      child: Scaffold(
        appBar: const NftAppBar(appBarTitle: "Restore wallet"),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _titleRestoreWallet(),
              _formListForRestoringWallet(),
              _nextButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _titleRestoreWallet() {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0),
      child: Text(
        'restore_screen.title'.tr(),
        style: const TextStyle(fontSize: 14.0, fontStyle: FontStyle.normal),
        textAlign: TextAlign.start,
      ),
    );
  }

  Widget _formListForRestoringWallet() {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: _controllers.length,
        itemBuilder: (context, index) => ListTile(
          title: Form(
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
      ),
    );
  }

  Widget _nextButton() {
    return BlocConsumer<RestoreWalletBloc, RestoreWalletState>(
        builder: (_, state) => Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: NftButton(
                    textButton: 'next_button'.tr(),
                    width: double.infinity,
                    onPressed: () {
                      List<String> inputWords = _controllers
                          .map((controller) => controller.text.trim())
                          .map((e) => e.replaceAll(',', ''))
                          .toList();

                      bloc.add(ValidateRestoreEvent(mnemonic: inputWords.join(' '),));
                    },
                  ),
                ),
              ),
            ),
        listener: (context, state) {
          if (state is ValidateRestoreState) {
            Navigator.pushNamed(
                context, "/twentyWords/twentyWordsConfirm/pinCode",
                arguments: _controllers
                    .map((controller) => controller.text.trim())
                    .map((e) => e.replaceAll(',', ''))
                    .toList()
                    .join(' '));
          } else if (state is InvalidRestoreState) {
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
                    child: Text('restore_screen.invalid_seed'.tr()),
                  ),
                ),
              ),
            );
          }
        });
  }
}
