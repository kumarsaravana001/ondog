import 'package:flutter/material.dart';
import 'package:ondgo_flutter/utilities/index.dart';
import 'config/config_index.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
              height: 34.h,
              decoration: BoxDecoration(
                  color: AppColors.black,
                  borderRadius: BorderRadius.circular(20)),
              child: SvgPicture.asset(
                IconAssets.scoreicon,
                color: AppColors.black,
              )),
        ),
      ),
    );
  }
}
