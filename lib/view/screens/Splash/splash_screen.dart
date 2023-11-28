// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../config/config_index.dart';

class SplashScreentwo extends StatefulWidget {
  const SplashScreentwo({Key? key}) : super(key: key);

  @override
  _SplashScreentwoState createState() => _SplashScreentwoState();
}

class _SplashScreentwoState extends State<SplashScreentwo> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      GoRouter.of(context).go('/signup');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Center(
              child: SvgPicture.asset(
                IconAssets.ondgoTextlogo,
                semanticsLabel: 'Ondgo Logo',
              ),
            ),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Text(
                AppLocalisation.continues,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
