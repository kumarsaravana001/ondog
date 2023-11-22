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

  static Widget art() {
    return Image.asset("assets/images/art.png", fit: BoxFit.cover);
  }

  static Widget business() {
    return Image.asset("assets/images/Business.png", fit: BoxFit.cover);
  }

  static Widget business1({double? height, double? width, BoxFit? fit}) {
    return Image.asset(
      "assets/images/Business.png",
      width: width,
      height: height,
      fit: fit,
    );
  }

  static Widget economy() {
    return Image.asset("assets/images/Economy.png", fit: BoxFit.cover);
  }

  static Widget education() {
    return Image.asset("assets/images/Education.png", fit: BoxFit.cover);
  }

  static Widget finance() {
    return Image.asset("assets/images/Finance.png", fit: BoxFit.cover);
  }

  static Widget healthcare() {
    return Image.asset("assets/images/Healthcare.png", fit: BoxFit.cover);
  }

  static Widget impactandSustainability() {
    return Image.asset("assets/images/ImpactandSustainability.png",
        fit: BoxFit.cover);
  }

  static Widget legal() {
    return Image.asset("assets/images/Legal.png", fit: BoxFit.cover);
  }

  static Widget music() {
    return Image.asset("assets/images/Music.png", fit: BoxFit.cover);
  }

  static Widget spirituality() {
    return Image.asset("assets/images/Spirituality.png", fit: BoxFit.cover);
  }

  static Widget sports() {
    return Image.asset("assets/images/Sports.png", fit: BoxFit.cover);
  }

  static Widget technology() {
    return Image.asset("assets/images/Technology.png", fit: BoxFit.cover);
  }

  static Widget travel() {
    return Image.asset("assets/images/Travel.png", fit: BoxFit.cover);
  }

  static Widget wellness() {
    return Image.asset("assets/images/Wellness.png", fit: BoxFit.cover);
  }
}
