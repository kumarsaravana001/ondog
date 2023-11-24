import 'package:flutter/material.dart';
import 'package:ondgo_flutter/utilities/app_banner_list.dart';
import '../config/config_index.dart';

class HorizontalScrollableCard extends StatelessWidget {
  const HorizontalScrollableCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: playlistimagePaths.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: 150,
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: AppColors.black,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.sp, horizontal: 14.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(playlistcardnames[index],
                              style: AppTestStyle.headingint(
                                  fontSize: 16.sp,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold)),
                          Text(AppLocalisation.ratingcount,
                              style: AppTestStyle.headingint(
                                  fontSize: 15.sp,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                      AppIconsWidget.horizontaldiamond(
                          color: AppColors.white, size: 15),
                    ],
                  ),
                ),
                Expanded(
                  child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                      child: playlistimagePaths[index]),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
