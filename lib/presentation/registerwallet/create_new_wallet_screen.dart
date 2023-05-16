import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_svg/svg.dart';

import '../commonwidgets/common_widgets.dart';

class CreateNewWalletScreen extends StatelessWidget {
  const CreateNewWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _appTitleName(),
            _imageWallet(),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _createNewWalletButton(context),
                _restoreWalletButton(context),
              ],
            )

          ],
        ),
      ),
    );
  }

  Widget _appTitleName() {
    return Center(
      child: Text(
        'app_name'.tr(),
        style: const TextStyle(
          fontSize: 30,
          fontStyle: FontStyle.normal,
        ),
      ),
    );
  }

  Widget _imageWallet() {
    return Center(
    );
  }

  Widget _createNewWalletButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 54, right: 54),
          child: NftButton(
            textButton: 'create_new_wallet_screen.create'.tr(),
            width: double.infinity,
            onPressed: () {
              Navigator.pushNamed(context, '/twentyWords');
            },
          ),
        ),
      ),
    );
  }

  Widget _restoreWalletButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Center(
        child: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/restoreScreen');
          },
          child: Text(
            'create_new_wallet_screen.restore'.tr(),
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}