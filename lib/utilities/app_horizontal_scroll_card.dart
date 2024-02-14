import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ondgo_flutter/utilities/app_banner_list.dart';
import '../config/config_index.dart';

class HorizontalScrollableCard extends StatelessWidget {
  const HorizontalScrollableCard({
    super.key,
    this.subtitle = '',
    this.cardbackgroundcolor = AppColors.black,
    this.textColor = AppColors.black,
    required this.cardStatusColor,
    required this.imageList,
    required this.showIds,
    required this.onTap,
    required this.imageListCount,
    required this.titlecard,
  });

  final Color cardStatusColor;
  final Color cardbackgroundcolor;
  final List<Widget> imageList;
  final int imageListCount;
  final Function(String showId) onTap;
  final List<String>? showIds;
  final String subtitle;
  final Color textColor;
  final List<String> titlecard;

  String _truncateTitle(String title) {
    List<String> words = title.split(' ');
    if (words.length > 1) {
      return '${words[0]} ...';
    } else {
      return title;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: imageListCount,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              if (showIds != null && index < showIds!.length) {
                onTap(showIds![index]);
              }
            },
            child: Container(
              width: 42.w,
              margin: EdgeInsets.all(12.sp),
              decoration: BoxDecoration(
                  color: cardbackgroundcolor,
                  borderRadius: BorderRadius.circular(15.0)),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 12.sp, horizontal: 14.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _truncateTitle(titlecard[index]),
                              style: AppTestStyle.headingint(
                                fontSize: 16.sp,
                                color: textColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            AppIconsWidget.horizontaldiamond(
                                color: cardStatusColor, size: 15),
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
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                    child: AspectRatio(
                      aspectRatio: 16 / 15.7,
                      child: imageList[index],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class HorizontalScrollableCard1 extends StatelessWidget {
  const HorizontalScrollableCard1({
    super.key,
    required this.subtitle,
    this.cardbackgroundcolor = AppColors.black,
    this.textColor = AppColors.black,
    required this.cardStatusColor,
    required this.imageList,
    required this.imageListCount,
    required this.showIds,
    required this.onTap,
    required this.titlecard,
    this.episodeId,
  });

  final Color cardStatusColor;
  final Color cardbackgroundcolor;
  final List<Widget> imageList;
  final int imageListCount;
  final List<String> subtitle;
  final Color textColor;
  final List<String> titlecard;
  final Function(String showId) onTap;
  final List<String>? showIds;
  final List<String>? episodeId;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: imageListCount,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              if (showIds != null && index < showIds!.length) {
                onTap(showIds![index]);
              }
            },
            child: Container(
              width: 42.w,
              margin: EdgeInsets.all(12.sp),
              decoration: BoxDecoration(
                  color: cardbackgroundcolor,
                  borderRadius: BorderRadius.circular(15.0)),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 12.sp, horizontal: 14.sp),
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
                                color: cardStatusColor, size: 15),
                          ],
                        ),
                        if (subtitle.isNotEmpty)
                          Text("Episode ${subtitle[index]}",
                              style: AppTestStyle.headingint(
                                  fontSize: 15.sp,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                    child: AspectRatio(
                      aspectRatio: 18 / 15.7,
                      child: imageList[index],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
