//Radio theme
import 'package:flutter/material.dart';
import 'package:sylonow/utils/constants/app_colors.dart';

class TRadioTheme {
  TRadioTheme._();

  static RadioThemeData lightRadioTheme = RadioThemeData(
    fillColor: WidgetStateProperty.all(TColors.primary),
  );
}
