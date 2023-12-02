import 'package:flutter/material.dart';
import 'package:ondgo_flutter/utilities/app_banner_list.dart';
import '../config/config_index.dart';

// ignore: must_be_immutable
class HorizontalScrollableCard extends StatelessWidget {
  String subtitle;
  Color cardbackgroundcolor;
  Color textColor;
  HorizontalScrollableCard({
    Key? key,
    this.subtitle = '',
    this.cardbackgroundcolor = AppColors.black,
    this.textColor = AppColors.black,
  }) : super(key: key);

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
            width: 42.w,
            margin: EdgeInsets.all(12.sp),
            decoration: BoxDecoration(
                color: cardbackgroundcolor,
                borderRadius: BorderRadius.circular(15.0)),
            child: Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 12.sp, horizontal: 14.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(playlistcardnames[index],
                              style: AppTestStyle.headingint(
                                  fontSize: 16.sp,
                                  color: textColor,
                                  fontWeight: FontWeight.bold)),
                          AppIconsWidget.horizontaldiamond(
                              color: Colors.amber, size: 15),
                        ],
                      ),
                      if (subtitle.isNotEmpty)
                        Text(subtitle,
                            style: AppTestStyle.headingint(
                                fontSize: 15.sp,
                                color: AppColors.white,
                                fontWeight: FontWeight.bold)),
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
