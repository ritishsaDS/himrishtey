import 'package:flutter/material.dart';

import 'custom_theme.dart';


const Color primaryColor = Color(0xff55B6DA);

final ThemeData lightTheme = ThemeData(
  primaryColor: primaryColor,
  scaffoldBackgroundColor: Colors.white,
  fontFamily: "Poppins",
  textTheme:  TextTheme(
    headline6: const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
    bodyText1: TextStyle(
      color: Colors.grey.shade500,
    ),
    headline3: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 13
    ),
  ),
  colorScheme: ColorScheme.fromSwatch()
      .copyWith(primary: primaryColor, secondary: primaryColor),
)
  ..addCustomTheme(
    const CustomThemeFields(
        logoBackground: Color(0xfff8f8f8),
        white: Colors.white,
        facebookBlue: Color(0xff1877F2),
        black: Color(0xff000000),
        greyLight: Color(0xffE5E5E5),
        grey: Color(0xffB7B7B7),
        blackText: Color(0xff193046),
        red: Colors.red,
        dropBackground: Color(0xff4CC9F8),
        blumine: Color(0xff175873),
        kashmirBlue: Color(0xff526C9C),
        polar: Color(0xffEFFAFB),
        prairieDust: Color(0xffE0CCAD),
        primaryButtonColors: [
          Color(0xff44B3E7),
          Color(0xff7ED0E0),
          Color(0xffABDFE9),
          Color(0xff8EEDFF),
        ],
        dialogeGredient: [
          Color(0xffFF5EF9),
          Color(0xffA991F9),
          Color(0xff22E2FE),
        ],
        shadowBlue: Color(0xff7888A6),
        davyGrey: Color(0xff5B5B5B)),
  )
  ;