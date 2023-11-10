import 'package:flutter/material.dart';

class AppImages {
  static Widget profilelevels({double? height, double? width}) {
    return Image.asset(
      "assets/images/profile_levels.png",
      width: width,
      height: height,
      // fit: BoxFit.cover,
    );
  }
}
