import 'package:flutter/material.dart';

import '../theme/theme_colors.dart';
import '../theme/theme_text_styles.dart';

/// Кнопка с цифрой для ввода кода
class UiButtonAuthNumber extends StatefulWidget {
  final VoidCallback onPressed;
  final int number;

  const UiButtonAuthNumber({required this.number, required this.onPressed})
      : super();

  @override
  _UiButtonAuthNumberState createState() => _UiButtonAuthNumberState();
}

class _UiButtonAuthNumberState extends State<UiButtonAuthNumber> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      child: RawMaterialButton(
        onPressed: null,
        elevation: 0.0,
        constraints: const BoxConstraints.tightFor(
          width: 64.0,
          height: 64.0,
        ),
        shape: const CircleBorder(
            side: BorderSide(
          width: 1,
          color: ThemeColors.Blue2,
          style: BorderStyle.solid,
        )),
        fillColor: _fillColor,
        child: Text(widget.number.toString(), style: _textStyle),
      ),
    );
  }

  Color get _fillColor {
    if (_pressed) {
      return ThemeColors.Blue3;
    } else {
      return ThemeColors.White;
    }
  }

  TextStyle get _textStyle {
    if (_pressed) {
      return ThemeTextStyles.AuthButton.apply(color: ThemeColors.White);
    } else {
      return ThemeTextStyles.AuthButton;
    }
  }
}
