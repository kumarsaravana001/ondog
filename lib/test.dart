import 'package:flutter/material.dart';
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
      body: Column(
        children: [
          SvgPicture.asset(IconAssets.ondgoTextlogowhite),
          SvgPicture.asset(IconAssets.reelsleftindicator),
          SvgPicture.asset(IconAssets.reelscenterindicator),
          SvgPicture.asset(IconAssets.reelsrightindicator),
        ],
      ),
    );
  }
}
