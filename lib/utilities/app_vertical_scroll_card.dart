import 'package:flutter/material.dart';
import 'package:ondgo_flutter/utilities/app_banner_list.dart';
import '../config/config_index.dart';

class AppVerticalScrollCard extends StatelessWidget {
  final List<Widget> imageList;
  final List<String>? titlecard;

  const AppVerticalScrollCard({
    super.key,
    required this.imageList,
    this.titlecard,
  });
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
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          mainAxisExtent: 200),
      itemCount: eventimagepathtitle.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          decoration: BoxDecoration(
              color: AppColors.black,
              borderRadius: BorderRadius.circular(15.0)),
          child: Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 10.sp, horizontal: 14.sp),
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
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(AppLocalisation.ddmm,
                            style: AppTextStyle.headingint(
                                fontSize: 16.sp,
                                color: AppColors.white,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                    // Text(AppLocalisation.commingsoon,
                    //     style: AppTestStyle.headingint(
                    //         fontSize: 15.sp,
                    //         color: AppColors.white,
                    //         fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Expanded(child: imageList[index]),
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15)),
                child: Container(
                  height: 10,
                  color: Colors.purple,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class AppVerticalScrollCard1 extends StatelessWidget {
  final List<String>? titleCard;
  final List<String>? subtitleCard;
  final List<Widget> imageList;
  final int imageListCount;
  final Function(String showId) onTap;
  final List<String>? showIds;

  const AppVerticalScrollCard1({
    super.key,
    required this.titleCard,
    this.subtitleCard,
    required this.imageList,
    required this.imageListCount,
    required this.onTap,
    this.showIds,
  });
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
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          mainAxisExtent: 200),
      itemCount: imageListCount,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            if (showIds != null && index < showIds!.length) {
              onTap(showIds![index]);
            }
          },
          child: Container(
            decoration: BoxDecoration(
                color: AppColors.black,
                borderRadius: BorderRadius.circular(15.0)),
            child: Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.sp, horizontal: 14.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(titleCard![index],
                              style: AppTextStyle.headingint(
                                  fontSize: 13.sp,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold)),
                          Text(subtitleCard![index],
                              style: AppTextStyle.headingint(
                                  fontSize: 16.sp,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                      // Assuming you want to show some static text or you can modify it to use list values
                      Text("Coming soon",
                          style: AppTextStyle.headingint(
                              fontSize: 15.sp,
                              color: AppColors.white,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                Expanded(
                  // Assuming eventsImagepath is a widget that takes a string (image path)
                  // and you have an equivalent widget or method to display images
                  child: imageList[index],
                ),
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15)),
                  child: Container(
                    height: 10,
                    color: Colors.purple,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
