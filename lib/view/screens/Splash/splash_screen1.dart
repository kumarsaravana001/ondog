import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ondgo_flutter/view/view_index.dart';

import '../../../config/config_index.dart';

class SplashScreen1 extends StatefulWidget {
  const SplashScreen1({Key? key}) : super(key: key);

  @override
  _SplashScreen1State createState() => _SplashScreen1State();
}

class _SplashScreen1State extends State<SplashScreen1> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      GoRouter.of(context).go("/signup");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Center(
        child: SvgPicture.asset(
          IconAssets.ondgoLogo,
          semanticsLabel: 'Ondgo Logo',
        ),
      ),
    );
  }
}
