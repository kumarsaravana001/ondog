import 'package:flutter/widgets.dart';
import '../../../config/config_index.dart';
import '../../../utilities/index.dart';

class MediaSection extends StatefulWidget {
  final VoidCallback? onWatchNowPressed;
  const MediaSection({super.key, this.onWatchNowPressed});

  @override
  State<MediaSection> createState() => _MediaSectionState();
}

class _MediaSectionState extends State<MediaSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36.h,
      decoration: BoxDecoration(
          color: AppColors.black, borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 10.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalisation.coffeewithcrypto,
                  style: AppTestStyle.headingBai(
                    fontSize: 22.sp,
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                AppIconsWidget.horizontaldiamond(
                    color: AppColors.white, size: 15),
              ],
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                AppImages.dummyimage(),
                Positioned(
                  bottom: 12.sp,
                  right: 12.sp,
                  child: CustomElevatedButton(
                      backgroundcolor: AppColors.black,
                      bordercolor: AppColors.black,
                      fontsize: 16.sp,
                      labelcolor: AppColors.white,
                      onPressed: widget.onWatchNowPressed,
                      // () {
                      //   setState(() {
                      //     showWatchedContent = true;
                      //   });
                      // },
                      text: 'Watch now'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
