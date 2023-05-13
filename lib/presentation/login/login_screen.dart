import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:juding/presentation/login/bloc/login_bloc.dart';
import 'package:juding/presentation/login/bloc/login_event.dart';
import 'package:juding/presentation/login/bloc/login_state.dart';
import 'package:pinput/pinput.dart';
import '../../di/service_locator.dart';
import 'login_keyboard.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _scaffoldKey =
      GlobalKey<ScaffoldState>(debugLabel: 'LoginScreenScaffoldKey');
  final controller = TextEditingController();
  final focusNode = FocusNode();
  final eraseKey = -1;
  final _authCodeLength = 6;
  final LoginBloc bloc = serviceLocator();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (_) => bloc,
      child: Scaffold(
        key: _scaffoldKey,
        body: SafeArea(child: _renderScreen()),
      ),
    );
  }

  Widget _renderScreen() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _title(),
          _codeAndKeyboard(),
        ]);
  }

  Widget _title() {
    return Container(
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.only(
        top: 48,
        left: 16,
        right: 16,
      ),
      child: Text(
        "login_screen.title".tr(),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _codeAndKeyboard() {
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 60,
          child: Pinput(
            length: _authCodeLength,
            controller: controller,
            focusNode: focusNode,
            defaultPinTheme: defaultPinTheme,
            obscureText: true,
            obscuringWidget: Container(
              decoration: const BoxDecoration(
                  color: borderColor, shape: BoxShape.circle),
            ),
            onChanged: (pin) {
              if (pin.length == _authCodeLength) {
                bloc.add(ValidateLoginEvent(password: controller.text));
              }
            },
          ),
        ),
        _keyboard()
      ],
    );
  }

  Widget _keyboard() {
    return BlocConsumer<LoginBloc, LoginState>(
        builder: (_, state) => LoginKeyboard(
              onPressed: (numberKeyPressed) {
                if (numberKeyPressed == eraseKey) {
                  if (controller.text.isNotEmpty) {
                    controller.text = controller.text
                        .substring(0, controller.text.length - 1);
                  }
                  return;
                }
                if (controller.text.length == _authCodeLength) {
                  return;
                } else if (controller.text.length < _authCodeLength) {
                  controller.text += numberKeyPressed.toString();
                }
              },
              eraseKeyActive: controller.text.isNotEmpty,
            ),
        listener: (context, state) => {
              if (state is ValidateLoginState)
                {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/pinCodeConfirmSuccess', (r) => false)
                }
              else if (state is InvalidateLoginState)
                {controller.clear(), showFlashAboutInvalidSeed()}
            });
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
            child: Text('login_screen.invalid_password'.tr(),
                style: const TextStyle(fontSize: 18)),
          ),
        ),
      ),
    );
  }
}
