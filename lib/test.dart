import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'config/config_index.dart';

class testScreen extends StatefulWidget {
  const testScreen({super.key});

  @override
  State<testScreen> createState() => _testScreenState();
}

class _testScreenState extends State<testScreen> {
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
