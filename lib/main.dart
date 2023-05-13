import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:juding/di/service_locator.dart';
import 'package:juding/presentation/login/login_keyboard.dart';
import 'package:juding/presentation/login/login_screen.dart';
import 'package:juding/presentation/registerwallet/create_new_wallet_screen.dart';
import 'package:juding/presentation/registerwallet/pin/pin_code_screen.dart';
import 'package:juding/presentation/registerwallet/pin/pin_code_success_screen.dart';
import 'package:juding/presentation/registerwallet/pin/pincodeconfirm/pin_code_confirm_screen.dart';
import 'package:juding/presentation/registerwallet/twentywordsconfirm/twenty_words_confirm_screen.dart';
import 'package:juding/presentation/registerwallet/twentywords/twenty_words_screen.dart';
import 'package:juding/presentation/restorewallet/restore_wallet_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  init();
  await serviceLocator.allReady();
  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en')],
        startLocale: const Locale('en'),
        path: "assets/strings",
        child: NamedRouter()),
  );
}

class NamedRouter extends StatelessWidget {
  NamedRouter({super.key});

  SharedPreferences prefs = serviceLocator<SharedPreferences>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      routes: {
        //navigation flow create_new_wallet_scenario
        '/': (context) => _passwordOrCreateNewWalletScreen(),
        '/twentyWords': (context) => const TwentyWordsScreen(),
        '/twentyWords/twentyWordsConfirm': (context) =>
            const TwentyWordsConfirmScreen(),
        '/twentyWords/twentyWordsConfirm/pinCode': (context) =>
            const PinCodeScreen(),
        '/twentyWords/twentyWordsConfirm/pinCode/pinCodeConfirm': (context) =>
            PinCodeConfirmScreen(),
        '/pinCodeConfirmSuccess': (context) => const PinCodeSuccessScreen(),
        // //navigation flow restore wallet
        '/restoreScreen': (context) => const RestoreScreen(),
        // '/bottomNavigationShopScreen': (context) => RoleChooseScreen(),
        // '/bottomNavigationShopScreen/detailNftCollection': (context) => _navigateToDetailNftCollectionScreenWithProvideTopUpBloc(),
        // '/bottomNavigationShopScreen/detailNftCollection/qrcodeshow': (context) => QrScreen(),
        // '/bottomNavigationShopScreen/detailNftShop': (context) => DetailNftShopScreen(),
        // '/bottomNavigationShopScreen/shopScreen': (context) => const ShopScreen(),
        // '/bottomNavigationShopScreen/webview': (context) => WebViewBinance(),
        // '/bottomNavigationShopScreen/detailNftShop/qrcamera': (context) => QRViewExample(),
      },
    );
  }

// Widget _navigateToDetailNftCollectionScreenWithProvideTopUpBloc(){
//   return BlocProvider(
//       create: (_) => serviceLocator<TopUpBloc>(),
//       child: const DetailNftCollectionScreen());
// }

Widget _passwordOrCreateNewWalletScreen() {
  if(prefs.getBool("isNotFirstEnter") != null && prefs.getBool("isNotFirstEnter")!){
    return const LoginScreen();
  } else {
    return const CreateNewWalletScreen();
  }
}
}
