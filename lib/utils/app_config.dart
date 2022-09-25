import 'dart:io';

import 'package:flutter/material.dart';

import 'custom_theme.dart';


class AppConfig {
  static double height = 0.0;
  static double width = 0.0;
  static Size size = const Size(0, 0);
  static String? deviceType;
  static GlobalKey<NavigatorState> materialKey = GlobalKey<NavigatorState>();

  static ThemeData theme = Theme.of(materialKey.currentContext!);
  static CustomThemeFields themeCustom =
  Theme.of(materialKey.currentContext!).custom();


  static void init(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    deviceType = Platform.isAndroid == true ? "android" : "ios";
    theme = Theme.of(context);

  }

  static Widget sizedBoxV(double size) {
    return SizedBox(
      height: height * size,
    );
  }

  static Widget sizedBoxH(double size) {
    return SizedBox(
      width: width * size,
    );
  }

  static SliverToBoxAdapter sliverSizedBoxV(double size) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: height * size,
      ),
    );
  }

  static EdgeInsetsGeometry paddingSymmetric(
      double vertical, double horizontal) {
    return EdgeInsets.symmetric(
      horizontal: AppConfig.width * horizontal,
      vertical: AppConfig.height * vertical,
    );
  }

  static EdgeInsetsGeometry paddingAll(double padding) {
    return EdgeInsets.symmetric(
      horizontal: AppConfig.width * padding * 02,
      vertical: AppConfig.height * padding,
    );
  }

  static EdgeInsetsGeometry marginAll(double padding) {
    return EdgeInsets.symmetric(
      horizontal: AppConfig.width * padding * 02,
      vertical: AppConfig.height * padding,
    );
  }

  static EdgeInsetsGeometry marginSymmetric(
      double vertical, double horizontal) {
    return EdgeInsets.symmetric(
      horizontal: AppConfig.width * horizontal,
      vertical: AppConfig.height * vertical,
    );
  }
}
