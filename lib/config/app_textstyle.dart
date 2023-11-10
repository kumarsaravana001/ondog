import 'package:flutter/material.dart';

import 'config_index.dart';

class AppTestStyle {
  static TextStyle headingBai(
      {Color color = Colors.black,
      double fontSize = 20,
      FontWeight fontWeight = FontWeight.bold}) {
    return TextStyle(
      fontFamily: 'BaiJamjuree',
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }

  static TextStyle headingint({
    Color color = Colors.black,
    double fontSize = 20,
    FontWeight fontWeight = FontWeight.normal,
    bool underline = false,
    bool italic = false,
  }) {
    return TextStyle(
        fontFamily: 'inter',
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        decoration: underline ? TextDecoration.underline : TextDecoration.none,
        fontStyle: italic ? FontStyle.italic : FontStyle.normal,
        decorationColor: AppColors.white);
  }

  static TextStyle headingope(
      {Color color = Colors.black,
      double fontSize = 20,
      FontWeight fontWeight = FontWeight.bold}) {
    return TextStyle(
      fontFamily: 'OpenSans',
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }
}
