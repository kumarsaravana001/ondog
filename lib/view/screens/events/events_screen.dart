// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

import '../../../config/config_index.dart';
import '../../../utilities/app_vertical_scroll_card.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({Key? key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.sp),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 15.0,
                              mainAxisSpacing: 15.0,
                              mainAxisExtent: 190),
                      itemCount: 11,
                      itemBuilder: (BuildContext context, int index) {
                        return const AppVerticalScrollCard();
                      },
                    ),
                  ),
                ),
                SizedBox(height: 4.h),
              ],
            ),
            Positioned(
              top: 0,
              right: 30,
              child: Row(
                children: [SvgPicture.asset(IconAssets.badgeclose)],
              ),
            ),
            Positioned(
              top: 10,
              left: 20,
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(Icons.arrow_back_outlined,
                        color: AppColors.white, size: 30),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
