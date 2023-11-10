import 'package:flutter/material.dart';
import 'package:ondgo_flutter/config/config_index.dart';
import '../../../utilities/app_horizontal_scroll_card.dart';

class PlayListScreen extends StatefulWidget {
  const PlayListScreen({super.key});

  @override
  State<PlayListScreen> createState() => _PlayListScreenState();
}

class _PlayListScreenState extends State<PlayListScreen> {
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
                  AppLocalisation.yourplaylist,
                  style: AppTestStyle.headingBai(fontSize: 26.sp),
                ),
              ),
              HorizontalScrollableCard(),
              Align(
                alignment: Alignment.center,
                child: Text(
                  AppLocalisation.videos,
                  style: AppTestStyle.headingBai(fontSize: 26.sp),
                ),
              ),
              HorizontalScrollableCard(),
            ],
          ),
        ],
      ),
    );
  }
}
