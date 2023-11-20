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

  static Widget dummyimage({double? height, double? width, BoxFit? fit}) {
    return Image.asset(
      "assets/images/dummy.png",
      width: width,
      height: height,
      fit: fit,
    );
  }

  static Widget reelsimage({double? height, double? width, BoxFit? fit}) {
    return Image.asset(
      "assets/images/reels_image.png",
      width: width,
      height: height,
      fit: fit,
    );
  }
}
