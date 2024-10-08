import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../config/config_index.dart';

class HorizontalScrollableCard extends StatelessWidget {
  const HorizontalScrollableCard({
    super.key,
    this.subtitle = '',
    this.cardbackgroundcolor = AppColors.black,
    this.textColor = AppColors.black,
    required this.cardStatusColor,
    required this.imageList,
    this.showIds,
    required this.onTap,
    required this.imageListCount,
    this.titlecard,
  });

  final Color cardStatusColor;
  final Color cardbackgroundcolor;
  final List<Widget> imageList;
  final int imageListCount;
  final Function(String showId) onTap;
  final List<String>? showIds;
  final String subtitle;
  final Color textColor;
  final List<String>? titlecard;

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
      height: 25.h,
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
                              _truncateTitle(titlecard![index]),
                              style: AppTextStyle.headingint(
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
                              style: AppTextStyle.headingint(
                                  italic: true,
                                  fontSize: 15.sp,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.normal)),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                        child: imageList[index],
                      ),
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
    required this.episodeId,
  });

  final Color cardStatusColor;
  final Color cardbackgroundcolor;
  final List<Widget> imageList;
  final int imageListCount;
  final List<String> subtitle;
  final Color textColor;
  final List<String> titlecard;
  final Function(String showId, String episodeId) onTap;
  final List<String>? showIds;
  final List<String>? episodeId;

  String _truncateTitle(String title) {
    List<String> words = title.split(' ');
    if (words.length > 1) {
      return '${words[0]} ...';
    } else {
      return title;
    }
  }

  String truncateTitle(String title) {
    List<String> words = title.split(' ');
    if (words.length > 1) {
      String firstWord = words[0];
      String secondWord =
          words[1].length > 3 ? '${words[1].substring(0, 3)}...' : words[1];
      return '$firstWord $secondWord';
    } else {
      return title;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
      height: 28.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: imageListCount,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              if (showIds != null &&
                  episodeId != null &&
                  index < showIds!.length &&
                  index < episodeId!.length) {
                onTap(
                  showIds![index],
                  episodeId![index],
                );
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
                            Text(truncateTitle(subtitle[index]),
                                style: AppTextStyle.headingint(
                                    fontSize: 16.sp,
                                    color: textColor,
                                    fontWeight: FontWeight.bold)),
                            AppIconsWidget.horizontaldiamond(
                                color: cardStatusColor, size: 15),
                          ],
                        ),
                        if (subtitle.isNotEmpty)
                          //titlecard
                          Text(truncateTitle(titlecard[index]),
                              // "${subtitle[index]}",
                              style: AppTextStyle.headingint(
                                  fontSize: 15.sp,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                        child: imageList[index],
                      ),
                    ),
                    //     Container(
                    //   width: double.infinity,
                    //   child: ClipRRect(
                    //     borderRadius: const BorderRadius.only(
                    //       bottomLeft: Radius.circular(15),
                    //       bottomRight: Radius.circular(15),
                    //     ),
                    //     child: Stack(
                    //       alignment: Alignment
                    //           .center, // Ensures the play button is centered
                    //       children: [
                    //         FittedBox(
                    //           fit: BoxFit
                    //               .contain, // This makes the image fully cover the area
                    //           child: imageList[index], // Your existing image
                    //         ),
                    //         Container(
                    //           decoration: BoxDecoration(
                    //             // Optional: Adds a slightly dark overlay to improve icon visibility
                    //             color: Colors.black.withOpacity(0.3),
                    //           ),
                    //         ),
                    //         const Icon(
                    //           Icons.play_circle_outline, // Play button icon
                    //           size: 50, // Adjust the size as needed
                    //           color: Colors.white, // Adjust the color as needed
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
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
