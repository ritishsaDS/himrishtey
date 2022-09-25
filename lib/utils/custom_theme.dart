import 'package:flutter/material.dart';

class CustomThemeFields {
  final Color logoBackground;
  final Color white;
  final Color facebookBlue;
  final Color black;
  final Color greyLight;
  final Color grey;
  final Color blackText;
  final Color red;
  final Color dropBackground;
  final Color blumine;
  final Color kashmirBlue;
  final Color polar;
  final Color prairieDust;
  final List<Color> primaryButtonColors;
  final Color shadowBlue;
  final List<Color> dialogeGredient;
  final Color davyGrey;

// must initilize constructor  value required
  const CustomThemeFields(
      {required this.logoBackground,
        required this.white,
        required this.facebookBlue,
        required this.black,
        required this.greyLight,
        required this.grey,
        required this.blackText,
        required this.red,
        required this.dropBackground,
        required this.blumine,
        required this.kashmirBlue,
        required this.polar,
        required this.prairieDust,
        required this.primaryButtonColors,
        required this.shadowBlue,
        required this.dialogeGredient,
        required this.davyGrey});
}

extension ThemeDataExtensions on ThemeData {
  static CustomThemeFields? customTheme;

  void addCustomTheme(CustomThemeFields custom) {
    customTheme = custom;
  }

  CustomThemeFields custom() {
    return customTheme!;
  }
}

CustomThemeFields customTheme(BuildContext context) =>
    Theme.of(context).custom();
