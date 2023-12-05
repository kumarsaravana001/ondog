// import 'package:flutter/material.dart';

// import '../../../config/config_index.dart';

// class ReelsFullScreen extends StatefulWidget {
//   // final Widget image;
//   const ReelsFullScreen({
//     super.key,
//   });

//   @override
//   State<ReelsFullScreen> createState() => _ReelsFullScreenState();
// }

// class _ReelsFullScreenState extends State<ReelsFullScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           AppImages.dummyimage(
//             fit: BoxFit.cover,
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height,
//           ),
//           Positioned(
//               bottom: 60.sp,
//               left: 20.sp,
//               child: SvgPicture.asset(IconAssets.reelsleftindicator)),
//           Positioned(
//               bottom: 50.sp,
//               left: MediaQuery.of(context).size.width / 2 - 20,
//               child: SvgPicture.asset(IconAssets.reelscenterindicator)),
//           Positioned(
//               bottom: 60.sp,
//               right: 20.sp,
//               child: SvgPicture.asset(IconAssets.reelsrightindicator)),
//           Positioned(
//             bottom: 35.sp,
//             left: 15.sp,
//             child: AppIconsWidget.favourites(color: AppColors.white),
//           ),
//           Positioned(
//             bottom: 33.sp,
//             left: MediaQuery.of(context).size.width * 2 / 9,
//             child: Text(
//               AppLocalisation.nutritiondaily,
//               style: AppTestStyle.headingBai(
//                   fontSize: 24.sp, color: AppColors.white),
//             ),
//           ),
//           Positioned(
//             bottom: 35.sp,
//             right: 15.sp,
//             child: AppIconsWidget.share(color: AppColors.white),
//           ),
//           Positioned(
//             bottom: 25.sp,
//             left: MediaQuery.of(context).size.width * 2 / 6,
//             child: Text(
//               AppLocalisation.newepisodes,
//               style: AppTestStyle.headingint(
//                   fontSize: 18.sp,
//                   fontWeight: FontWeight.w500,
//                   color: AppColors.white),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

import '../../../config/config_index.dart';

class ReelsFullScreen extends StatefulWidget {
  const ReelsFullScreen({Key? key}) : super(key: key);

  @override
  State<ReelsFullScreen> createState() => _ReelsFullScreenState();
}

class _ReelsFullScreenState extends State<ReelsFullScreen> {
  int _currentIndex = 0;
  final List<String> imagePaths = [
    'assets/images/dummy.png',
    'assets/images/Economy.png',
    'assets/images/Education.png',
    'assets/images/Finance.png',
    'assets/images/Healthcare.png',
    'assets/images/dummy.png',
    'assets/images/Economy.png',
    'assets/images/Education.png',
    'assets/images/Finance.png',
    'assets/images/Healthcare.png',
  ];

  @override
  Widget build(BuildContext context) {
    void nextImage() {
      if (_currentIndex < imagePaths.length - 1) {
        setState(() {
          _currentIndex++;
        });
      }
    }

    void previousImage() {
      if (_currentIndex > 0) {
        setState(() {
          _currentIndex--;
        });
      }
    }

    return Scaffold(
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          const double velocityThreshold = 1000;

          if (details.primaryVelocity != null &&
              details.primaryVelocity! < -velocityThreshold) {
            nextImage(); // Swipe right to left
          } else if (details.primaryVelocity != null &&
              details.primaryVelocity! > velocityThreshold) {
            previousImage(); // Swipe left to right
          }
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              imagePaths[_currentIndex],
              fit: BoxFit.cover,
            ),
            Positioned(
              bottom: 60.sp,
              left: 20.sp,
              child: SvgPicture.asset(IconAssets.reelsleftindicator),
            ),
            Positioned(
              bottom: 50.sp,
              left: MediaQuery.of(context).size.width / 2 - 20,
              child: SvgPicture.asset(IconAssets.reelscenterindicator),
            ),
            Positioned(
              bottom: 60.sp,
              right: 20.sp,
              child: SvgPicture.asset(IconAssets.reelsrightindicator),
            ),
            Positioned(
              bottom: 35.sp,
              left: 20.sp,
              child: AppIconsWidget.favourites(color: AppColors.white),
            ),
            Positioned(
              bottom: 33.sp,
              left: MediaQuery.of(context).size.width * 2 / 7,
              child: Text(
                AppLocalisation.nutritiondaily,
                style: AppTestStyle.headingBai(
                  fontSize: 24,
                  color: AppColors.white,
                ),
              ),
            ),
            Positioned(
              bottom: 35.sp,
              right: 20.sp,
              child: AppIconsWidget.share(color: AppColors.white),
            ),
            Positioned(
              bottom: 20.sp,
              left: MediaQuery.of(context).size.width * 2 / 6,
              child: Text(
                AppLocalisation.newepisodes,
                style: AppTestStyle.headingint(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
