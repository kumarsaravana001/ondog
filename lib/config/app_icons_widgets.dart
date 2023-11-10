// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import 'config_index.dart';

class AppIconsWidget {
  static const double _defaultSize = 24;
  static const Color _defaultColor = Colors.black;

  static Widget ondgoTextlogo(
          {double size = _defaultSize, Color color = _defaultColor}) =>
      SvgPicture.asset("assets/icons/text_logo.svg",
          width: size, height: size, color: color);

  static Widget ondgoLogo(
          {double size = _defaultSize, Color color = _defaultColor}) =>
      SvgPicture.asset("assets/icons/logo.svg",
          width: size, height: size, color: color);

//Signin
  static Widget signinBottom(
          {double size = _defaultSize, Color color = _defaultColor}) =>
      SvgPicture.asset("assets/icons/signin_bottom.svg",
          width: size, height: size, color: color);

  //profile

//common
  static Widget bottombgdiamond(
          {double size = _defaultSize, Color color = _defaultColor}) =>
      SvgPicture.asset(
        "assets/icons/bottom_bg_diamond.svg",
        width: size,
        height: size,
        color: color,
        fit: BoxFit.fitWidth,
      );
}
