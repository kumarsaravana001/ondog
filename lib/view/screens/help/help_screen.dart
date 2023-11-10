import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../config/app_textstyle.dart';
import '../../../config/config_index.dart';
import '../../../utilities/app_horizontal_scroll_card.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            bottom: -125,
            left: -10,
            right: 30,
            child: SvgPicture.asset(IconAssets.bottombgdiamond),
          ),
          Column(
            children: [
              SvgPicture.asset(
                  width: MediaQuery.of(context).size.width,
                  IconAssets.profilescreenbgblack),
              Align(
                alignment: Alignment.center,
                child: Text(
                  AppLocalisation.help,
                  style: AppTestStyle.headingBai(fontSize: 26.sp),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
