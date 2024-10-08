import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../bloc/showscreen_bloc/episodeVideoDetails_bloc/epidoseVideoDetail_bloc.dart';
import '../../../bloc/showscreen_bloc/episodeVideoDetails_bloc/epidoseVideoDetail_state.dart';
import '../../../bloc/showscreen_bloc/episodeDisplay_cubit.dart';
import '../../../bloc/showscreen_bloc/showDetails_bloc/show_details_bloc.dart';
import '../../../bloc/showscreen_bloc/showDetails_bloc/show_details_state.dart';
import '../../../config/config_index.dart';
import '../../../utilities/index.dart';

class MediaCoverSection extends StatefulWidget {
  const MediaCoverSection({super.key, this.onWatchNowPressed});

  final VoidCallback? onWatchNowPressed;

  @override
  State<MediaCoverSection> createState() => _MediaCoverSectionState();
}

class _MediaCoverSectionState extends State<MediaCoverSection> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DisplayCubit, DisplayState>(
      builder: (context, displayState) {
        switch (displayState) {
          case DisplayState.userDetails:
            return buildUserDetailsSection(context);  
          case DisplayState.videoDetails:
            return buildVideoDetailsSection(context);
          default:
            return const Text("Please select a show.");
        }
      },
    );
  }

  Widget buildUserDetailsSection(BuildContext context) {
    return BlocBuilder<UserShowDetailBloc, UserShowDetailState>(
      builder: (context, state) {
        if (state is UserShowDetailLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UserShowDetailLoaded &&
            state.userDetails.isNotEmpty) {
          final showDetails = state.userDetails.first;
          final String showTitle = showDetails.showName ?? "Loading ...";
          final String episodeNo = "";
          final formattedTitle = "Teaser: $showTitle";

          final String thumbnailUrl = showDetails.thumbnail?.isNotEmpty == true
              ? showDetails.thumbnail![0]
              : 'assets/images/health_care_banner.png';
          final Widget imageWidget = thumbnailUrl.isNotEmpty
              ? Image.network(thumbnailUrl,
                  fit: BoxFit.cover, height: 180, width: double.infinity)
              : Image.asset('assets/images/health_care_banner',
                  fit: BoxFit.cover, height: 200);
          return buildMediaSectionContent(
              formattedTitle, imageWidget, episodeNo,
              isUserDetail: true);
        } else if (state is UserShowDetailError) {
          print('Error UserShowDetailError: ${state.message}');
          return Center(
            child: Text('Error UserShowDetailError: ${state.message}'),
          );
        }
        return const Text("Please select a show.");
      },
    );
  }

  Widget buildVideoDetailsSection(BuildContext context) {
    return BlocBuilder<VideoDetailsBloc, VideoDetailsState>(
      builder: (context, state) {
        if (state is VideoDetailsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is VideoDetailsLoaded &&
            state.episodevideoDetails.isNotEmpty) {
          final videoDetail = state.episodevideoDetails.first;
          final String showTitle = videoDetail.title ?? "Loading ...";
          final String episodeNo = videoDetail.episodeNo ?? "";
          final formattedTitle = "Epi No $episodeNo : $showTitle";
          final String thumbnailUrl = videoDetail.thumbnail?.isNotEmpty == true
              ? videoDetail.thumbnail![0]
              : 'assets/images/health_care_banner.png';
          final Widget imageWidget = thumbnailUrl.isNotEmpty
              ? Image.network(thumbnailUrl,
                  fit: BoxFit.cover, height: 180, width: double.infinity)
              : Image.asset('assets/images/health_care_banner.png',
                  fit: BoxFit.cover, height: 200);
          return buildMediaSectionContent(
              formattedTitle, imageWidget, episodeNo,
              isUserDetail: false);
        }
        // else if (state is VideoDetailsError) {
        //   return const Center(
        //     child: Text("Please Check your Network Connectivity."),
        //   );
        //   //  Text('Error: ${state.message}');
        // }
        else if (state is VideoDetailsError) {
          print('Error VideoDetailsError: ${state.message}');
          return Center(
            child: Text('Error VideoDetailsError: ${state.message}'),
          );
        }
        return const Text("Please select an episode.");
      },
    );
  }

  Widget buildMediaSectionContent(
      String showTitle, Widget imageWidget, String episodeNo,
      {required bool isUserDetail}) {
    return Container(
      height: 28.h,
      decoration: BoxDecoration(
          color: AppColors.black, borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 12.sp, left: 15.sp, right: 18.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    // Text(
                    //   "$displayEpisodeNo: $displayShowTitle",
                    //   style: GoogleFonts.baiJamjuree(
                    //     fontSize: 22.sp,
                    //     color: AppColors.white,
                    //     fontWeight: FontWeight.w600,
                    //   ),
                    // ),
                    Text(
                      showTitle,
                      style: GoogleFonts.baiJamjuree(
                        fontSize: 20.sp,
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
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
                      onPressed: widget.onWatchNowPressed,
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
