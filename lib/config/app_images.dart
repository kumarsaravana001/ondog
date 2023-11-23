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

  static Widget arts({double? height, double? width, BoxFit? fit}) {
    return Image.asset("assets/images/arts.png",
        width: double.infinity, height: height, fit: BoxFit.cover);
  }

  static Widget business({double? height, double? width, BoxFit? fit}) {
    return Image.asset("assets/images/Business.png",
        width: double.infinity, height: height, fit: BoxFit.cover);
  }

  static Widget business1({double? height, double? width, BoxFit? fit}) {
    return Image.asset("assets/images/Business.png",
        width: double.infinity, height: height, fit: BoxFit.cover);
  }

  static Widget economy({double? height, double? width, BoxFit? fit}) {
    return Image.asset("assets/images/Economy.png",
        width: double.infinity, height: height, fit: BoxFit.cover);
  }

  static Widget education({double? height, double? width, BoxFit? fit}) {
    return Image.asset("assets/images/Education.png",
        width: double.infinity, height: height, fit: BoxFit.cover);
  }

  static Widget finance({double? height, double? width, BoxFit? fit}) {
    return Image.asset("assets/images/Finance.png",
        width: double.infinity, height: height, fit: BoxFit.cover);
  }

  static Widget healthcare({double? height, double? width, BoxFit? fit}) {
    return Image.asset("assets/images/Healthcare.png",
        width: double.infinity, height: height, fit: BoxFit.cover);
  }

  static Widget impactandSustainability(
      {double? height, double? width, BoxFit? fit}) {
    return Image.asset("assets/images/Impact_and_Sustainability.png",
        width: double.infinity, height: height, fit: BoxFit.cover);
  }

  static Widget legal({double? height, double? width, BoxFit? fit}) {
    return Image.asset("assets/images/Legal.png",
        width: double.infinity, height: height, fit: BoxFit.cover);
  }

  static Widget music({double? height, double? width, BoxFit? fit}) {
    return Image.asset("assets/images/Music.png",
        width: double.infinity, height: height, fit: BoxFit.cover);
  }

  static Widget spirituality({double? height, double? width, BoxFit? fit}) {
    return Image.asset("assets/images/Spirituality.png",
        width: double.infinity, height: height, fit: BoxFit.cover);
  }

  static Widget sports({double? height, double? width, BoxFit? fit}) {
    return Image.asset("assets/images/Sports.png",
        width: double.infinity, height: height, fit: BoxFit.cover);
  }

  static Widget technology({double? height, double? width, BoxFit? fit}) {
    return Image.asset("assets/images/Technology.png",
        width: double.infinity, height: height, fit: BoxFit.cover);
  }

  static Widget travel({double? height, double? width, BoxFit? fit}) {
    return Image.asset("assets/images/Travel.png",
        width: double.infinity, height: height, fit: BoxFit.cover);
  }

  static Widget wellness({double? height, double? width, BoxFit? fit}) {
    return Image.asset("assets/images/Wellness.png",
        width: double.infinity, height: height, fit: BoxFit.cover);
  }
}
