import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'button_auth_number.dart';

/// Цифровая клавиатура ввода кода авторизации
class LoginKeyboard extends StatefulWidget {
  final Function(int number) onPressed;
  bool eraseKeyActive;

  LoginKeyboard({super.key,
    required this.onPressed,
    required this.eraseKeyActive,
  });

  @override
  _LoginKeyboardState createState() => _LoginKeyboardState();
}

class _LoginKeyboardState extends State<LoginKeyboard> {
  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {
        0: FixedColumnWidth(64.0),
        1: FixedColumnWidth(128),
        2: FixedColumnWidth(64.0),
      },
      children: [
        TableRow(children: [
          _numberKey(1),
          _numberKey(2),
          _numberKey(3),
        ]),
        TableRow(children: [
          _numberKey(4),
          _numberKey(5),
          _numberKey(6),
        ]),
        TableRow(children: [
          _numberKey(7),
          _numberKey(8),
          _numberKey(9),
        ]),
        TableRow(children: [
          _dummy(),
          _numberKey(0, bottomPadding: false),
          _eraseKey(),
        ]),
      ],
    );
  }

  Widget _numberKey(int number, {bool bottomPadding = true}) {
    EdgeInsetsGeometry padding = EdgeInsets.only(
      bottom: bottomPadding ? 16 : 0,
    );
    return Padding(
      padding: padding,
      child: UiButtonAuthNumber(
          number: number, onPressed: () => _onNumberButtonPressed(number)),
    );
  }

  Widget _eraseKey() {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => _onNumberButtonPressed(-1),
      child: SizedBox(
        width: 64,
        height: 64,
        child: SvgPicture.asset(
          widget.eraseKeyActive ? "assets/images/erase.svg" : "assets/images/erase_inactive.svg",
          width: 28,
          height: 20,
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }

  Widget _dummy() {
    return SizedBox.fromSize(
      size: const Size.square(64),
    );
  }

  void _onNumberButtonPressed(int number) => widget.onPressed(number);
}
