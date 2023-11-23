import 'package:flutter/material.dart';
import '../../../config/config_index.dart';
import '../../../utilities/app_vertical_scroll_card.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

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
                      child: const AppVerticalScrollCard()),
                ),
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
