import 'package:flutter/material.dart';

import '../../../config/app_textstyle.dart';
import '../../../config/config_index.dart';
import '../../../utilities/app_vertical_scroll_card.dart';

class Events extends StatefulWidget {
  const Events({Key? key});

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
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
                  AppLocalisation.events,
                  style: AppTestStyle.headingBai(fontSize: 28.sp),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 100.sp),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15.0,
                    mainAxisSpacing: 15.0,
                  ),
                  itemCount: 11,
                  itemBuilder: (BuildContext context, int index) {
                    return const AppVerticalScrollCard();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
