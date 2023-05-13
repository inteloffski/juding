import 'package:flutter/material.dart';
import 'package:juding/presentation/theme/theme_colors.dart';

/// Стили текста, используемые в приложении
class ThemeTextStyles {
  ThemeTextStyles._();

  static const TextStyle H1_Headline = TextStyle(
    color: ThemeColors.FontDark,
    fontSize: 34,
    height: 1.18,
    letterSpacing: 0.1,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
  );

  static const TextStyle H2_Headline = TextStyle(
    color: ThemeColors.FontText,
    fontSize: 24,
    height: 1.33,
    letterSpacing: 0.1,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
  );

  static const TextStyle H3_Headline = TextStyle(
    color: ThemeColors.FontText,
    fontSize: 20,
    height: 1.2,
    letterSpacing: 0.1,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
  );

  static const TextStyle S1_Subhead = TextStyle(
    color: ThemeColors.FontText,
    fontSize: 16,
    height: 1.25,
    letterSpacing: 0.1,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
  );

  static const TextStyle S2_Subhead = TextStyle(
    color: ThemeColors.FontText,
    fontSize: 14,
    height: 1.12,
    letterSpacing: 0.2,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
  );

  static const TextStyle S3_Subhead = TextStyle(
    color: ThemeColors.FontText,
    fontSize: 12,
    height: 1.0,
    letterSpacing: 0.2,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
  );

  static const TextStyle B1_Body = TextStyle(
    color: ThemeColors.FontLight,
    fontSize: 16,
    height: 1.5,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
  );

  static const TextStyle B2_Body = TextStyle(
    color: ThemeColors.FontLight,
    fontSize: 14,
    height: 1.43,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
  );

  static const TextStyle N_Notes = TextStyle(
    color: ThemeColors.FontText,
    fontSize: 13,
    height: 1.23,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.normal,
  );

  static const TextStyle C_Caption = TextStyle(
    color: ThemeColors.FontLight,
    fontSize: 12,
    height: 1.33,
    letterSpacing: 0.0075,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.normal,
  );

  static const TextStyle M_Micro = TextStyle(
    color: ThemeColors.FontText,
    fontSize: 10,
    height: 1.2,
    letterSpacing: 0.4,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
  );

  static const TextStyle BigNum = TextStyle(
    color: ThemeColors.FontDark,
    fontSize: 40,
    height: 1.1,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
  );

  static const TextStyle Toolbar = TextStyle(
    color: ThemeColors.White,
    fontSize: 18,
    height: 1.16,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
  );

  static const TextStyle Button1 = TextStyle(
    color: ThemeColors.FontText,
    fontSize: 16,
    height: 1.2,
    letterSpacing: 0.75,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
  );

   static const TextStyle Button2 = TextStyle(
    color: ThemeColors.FontText,
    fontSize: 14,
    height: 1.2,
    letterSpacing: 0.75,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
  );

  static const TextStyle Button3 = TextStyle(
    color: ThemeColors.FontPrimary,
    fontSize: 12,
    height: 1.0,
    letterSpacing: 0.75,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
  );

  static const TextStyle AuthButton = TextStyle(
    color: ThemeColors.FontPrimary,
    fontSize: 36,
    height: 1.16,
    fontWeight: FontWeight.w200,
    fontStyle: FontStyle.normal,
  );

  static const TextStyle NumPadButton = TextStyle(
    color: ThemeColors.FontText,
    fontSize: 36,
    height: 1.16,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
  );
}
