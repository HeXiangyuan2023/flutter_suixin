import 'package:flutter/material.dart';
import 'dart:io';

import 'package:suixin_app/app_colors.dart';

class FontWeightXT {
  static const FontWeight regular = FontWeight.w400;

  static const FontWeight medium = FontWeight.w600;

  static const FontWeight bold = FontWeight.w700;
}

class AppTypography {
  /// `fontSize`: `18`, `color`: `primary`, bold
  static TextStyle h1() {
    return TextStyle(
        fontSize: 18,
        color: AppColors.light().textPrimary,
        fontWeight: FontWeightXT.bold);
  }

  /// `fontSize`: `16`, `color`: `primary`, medium
  static TextStyle h2() {
    return TextStyle(
        fontSize: 16,
        color: AppColors.light().textPrimary,
        fontWeight: FontWeightXT.medium);
  }

  /// `fontSize`: `14`, `color`: `primary` regular
  static TextStyle h3() {
    return TextStyle(
        fontSize: 14,
        color: AppColors.light().textPrimary,
        fontWeight: FontWeightXT.regular);
  }

  /// `fontSize`: `12`, `color`: `tertiary` regular
  static TextStyle h4() {
    return TextStyle(
        fontSize: 12,
        color: AppColors.light().textTertiary,
        fontWeight: FontWeightXT.regular);
  }

  /// `fontSize`: `11`, `color`: `tertiary` regular
  static TextStyle h5() {
    return TextStyle(
        fontSize: 11,
        color: AppColors.light().textTertiary,
        fontWeight: FontWeightXT.regular);
  }

  /// `fontSize`: `10`, `color`: `tertiary` regular
  static TextStyle h6() {
    return TextStyle(
        fontSize: 10,
        color: AppColors.light().textTertiary,
        fontWeight: FontWeightXT.regular);
  }

  /// `fontSize`: `15`, `color`: `primary` mediu
  static TextStyle h7() {
    return TextStyle(
        fontSize: 15,
        color: AppColors.light().textPrimary,
        fontWeight: FontWeightXT.medium);
  }
}
