import 'package:attend/core/values/attend_colors.dart';
import 'package:flutter/material.dart';

class TextStyles {
  static TextStyle get hintField => TextStyle(
        color: AttendColors.input_hint,
      );

  static TextStyle get inputField => TextStyle(
        color: AttendColors.input_text,
      );

  static TextStyle get universityListText => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get selectInfoText => TextStyle(
        fontWeight: FontWeight.w400,
      );
}
