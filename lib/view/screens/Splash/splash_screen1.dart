import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../config/config_index.dart';

class SplashScreenone extends StatefulWidget {
  const SplashScreenone({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenoneState createState() => _SplashScreenoneState();
}

class _SplashScreenoneState extends State<SplashScreenone> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      GoRouter.of(context).go("/splash2");
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
