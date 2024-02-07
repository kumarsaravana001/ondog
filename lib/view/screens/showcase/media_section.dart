// import 'package:flutter/widgets.dart';
// import '../../../config/config_index.dart';
// import '../../../utilities/index.dart';

// class MediaSection extends StatefulWidget {
//   final VoidCallback? onWatchNowPressed;
//   const MediaSection({super.key, this.onWatchNowPressed});

//   @override
//   State<MediaSection> createState() => _MediaSectionState();
// }

// class _MediaSectionState extends State<MediaSection> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 30.h,
//       decoration: BoxDecoration(
//           color: AppColors.black, borderRadius: BorderRadius.circular(20)),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 10.sp),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   AppLocalisation.coffeewithcrypto,
//                   style: AppTestStyle.headingBai(
//                     fontSize: 22.sp,
//                     color: AppColors.white,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 AppIconsWidget.horizontaldiamond(
//                     color: AppColors.white, size: 15),
//               ],
//             ),
//           ),
//           ClipRRect(
//             borderRadius: BorderRadius.circular(20),
//             child: Stack(
//               children: [
//                 AppImages.coffeebanner(fit: BoxFit.fitHeight),
//                 Positioned(
//                   bottom: 12.sp,
//                   right: 12.sp,
//                   child: CustomElevatedButton(
//                       backgroundcolor: AppColors.black,
//                       bordercolor: AppColors.black,
//                       fontsize: 16.sp,
//                       labelcolor: AppColors.white,
//                       onPressed: widget.onWatchNowPressed,
//                       // () {
//                       //   setState(() {
//                       //     showWatchedContent = true;
//                       //   });
//                       // },
//                       text: 'Watch now'),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/showscreen_bloc/show_details_bloc.dart';
import '../../../bloc/showscreen_bloc/show_details_state.dart';
import '../../../config/config_index.dart';
import '../../../utilities/index.dart';

class MediaSection extends StatelessWidget {
  final VoidCallback? onWatchNowPressed;

  const MediaSection({Key? key, this.onWatchNowPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserShowDetailBloc, UserShowDetailState>(
      builder: (context, state) {
        if (state is UserShowDetailLoading) {
          return CircularProgressIndicator();
        } else if (state is UserShowDetailLoaded &&
            state.userDetails.isNotEmpty) {
          final showDetails = state.userDetails.first;
          final String showTitle = showDetails.showName ?? "Loading ...";

          // Assuming `thumbnail` is of type String and using a fallback for the asset image.
          final String thumbnailUrl =
              showDetails.thumbnail ?? 'assets/images/health_care_banner.png';

          final Widget imageWidget = thumbnailUrl.isNotEmpty
              ? Image.network(thumbnailUrl, fit: BoxFit.cover, height: 200)
              : Image.asset('assets/images/default_image.png',
                  fit: BoxFit.cover, height: 200);

          return buildMediaSectionContent(showTitle, imageWidget);
        } else if (state is UserShowDetailError) {
          return Text('Error: ${state.message}');
        }
        return Text("Please select a show.");
      },
    );
  }

  Widget buildMediaSectionContent(String showTitle, Widget imageWidget) {
    return Container(
      height: 30.h,
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
                  showTitle,
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
                imageWidget,
                Positioned(
                  bottom: 12.sp,
                  right: 12.sp,
                  child: CustomElevatedButton(
                      backgroundcolor: AppColors.black,
                      bordercolor: AppColors.black,
                      fontsize: 16.sp,
                      labelcolor: AppColors.white,
                      onPressed: onWatchNowPressed,
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
