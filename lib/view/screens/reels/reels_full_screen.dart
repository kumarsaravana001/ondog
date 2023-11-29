import 'package:flutter/material.dart';

import '../../../config/config_index.dart';

class ReelsFullScreen extends StatefulWidget {
  // final Widget image;
  const ReelsFullScreen({
    super.key,
  });

  @override
  State<ReelsFullScreen> createState() => _ReelsFullScreenState();
}

class _ReelsFullScreenState extends State<ReelsFullScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              AppImages.dummyimage(
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
              Positioned(
                  bottom: 60.sp,
                  left: 20.sp,
                  child: SvgPicture.asset(IconAssets.reelsleftindicator)),
              Positioned(
                  bottom: 50.sp,
                  left: MediaQuery.of(context).size.width / 2 - 20,
                  child: SvgPicture.asset(IconAssets.reelscenterindicator)),
              Positioned(
                  bottom: 60.sp,
                  right: 20.sp,
                  child: SvgPicture.asset(IconAssets.reelsrightindicator)),
              Positioned(
                bottom: 35.sp,
                left: 15.sp,
                child: AppIconsWidget.favourites(color: AppColors.white),
              ),
              Positioned(
                bottom: 33.sp,
                left: MediaQuery.of(context).size.width * 2 / 9,
                child: Text(
                  AppLocalisation.nutritiondaily,
                  style: AppTestStyle.headingBai(
                      fontSize: 24.sp, color: AppColors.white),
                ),
              ),
              Positioned(
                bottom: 35.sp,
                right: 15.sp,
                child: AppIconsWidget.share(color: AppColors.white),
              ),
              Positioned(
                bottom: 25.sp,
                left: MediaQuery.of(context).size.width * 2 / 6,
                child: Text(
                  AppLocalisation.newepisodes,
                  style: AppTestStyle.headingint(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.white),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
