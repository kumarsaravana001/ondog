import 'package:flutter/material.dart';
import 'package:ondgo_flutter/config/config_index.dart';
import 'package:ondgo_flutter/utilities/app_banner_list.dart';
import '../../../utilities/app_horizontal_scroll_card.dart';

class PlayListScreen extends StatefulWidget {
  const PlayListScreen({super.key});

  @override
  State<PlayListScreen> createState() => _PlayListScreenState();
}

class _PlayListScreenState extends State<PlayListScreen> {
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
                    AppLocalisation.yourplaylist,
                    style: AppTestStyle.headingBai(fontSize: 26.sp),
                  ),
                ),
                HorizontalScrollableCard(
                  cardStatusColor: Colors.indigo,
                  imageListCount: playlistcardnames.length,
                  imageList: yourlistImagepath,
                  cardbackgroundcolor: AppColors.black,
                  textColor: AppColors.white,
                  showIds: [],
                  onTap: (String showId) {},
                  titlecard: [],
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    AppLocalisation.videos,
                    style: AppTestStyle.headingBai(fontSize: 26.sp),
                  ),
                ),
                HorizontalScrollableCard(
                  cardStatusColor: Colors.indigo,
                  imageListCount: playlistcardnames.length,
                  imageList: yourlistImagepath,
                  cardbackgroundcolor: AppColors.black,
                  textColor: AppColors.white,
                  showIds: [],
                  onTap: (String showId) {},
                  titlecard: [],
                )
              ],
            ),
            Positioned(
              top: 0,
              right: 30,
              child: Row(
                children: [SvgPicture.asset(IconAssets.badgeopen)],
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
