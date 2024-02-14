// ignore_for_file: unnecessary_brace_in_string_interps, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ondgo_flutter/utilities/app_banner_list.dart';
import 'package:ondgo_flutter/view/screens/homescreen/widgets/widget.dart';

import '../../../bloc/homescreen_bloc/category_wise_show_bloc/category_wise_show_bloc.dart';
import '../../../bloc/homescreen_bloc/category_wise_show_bloc/category_wise_show_state.dart';
import '../../../bloc/showscreen_bloc/showEpisodeDetails_bloc/showEpisode_details_bloc.dart';
import '../../../bloc/showscreen_bloc/showEpisodeDetails_bloc/showEpisode_details_event.dart';
import '../../../bloc/showscreen_bloc/showEpisodeDetails_bloc/showEpisode_details_state.dart';
import '../../../bloc/showscreen_bloc/showId_cubit.dart';
import '../../../config/config_index.dart';
import '../../../utilities/app_horizontal_scroll_card.dart';
import '../../../utilities/app_scrollable_elongated_card.dart';

class ShowCaseCardSections extends StatelessWidget {
  const ShowCaseCardSections({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserEpisodeDetailBloc>(
            create: (context) => UserEpisodeDetailBloc()),
      ],
      child: BlocListener<ShowIdCubit, int?>(
        listener: (context, showId) {
          if (showId != null) {
            context
                .read<UserEpisodeDetailBloc>()
                .add(FetchUserEpisodeDetail(showId: showId));
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.only(left: 18.sp),
                child: Text(AppLocalisation.episodes,
                    style: AppTestStyle.headingBai(fontSize: 26.sp))),
            Padding(
              padding: EdgeInsets.only(left: 15.sp),
              child: BlocBuilder<UserEpisodeDetailBloc, UserEpisodeDetailState>(
                builder: (context, state) {
                  if (state is UserEpisodeDetailLoading) {
                    return horizontalCardShimmerWidget(); // Show loading indicator while data is being fetched
                  } else if (state is UserEpisodeDetailLoaded &&
                      state.episodeDetails.isNotEmpty) {
                    List<String> showNames = state.episodeDetails
                        .map((show) => show.showName ?? 'No Show Name')
                        .toList();
                    List<String> showIds = state.episodeDetails
                        .map((show) => show.showId ?? 'No Show Name')
                        .toList();
                    List<String> episodeNum = state.episodeDetails
                        .map((show) => show.episodeId ?? 'No Show Name')
                        .toList();
                    print("Episode no ${episodeNum}");
                    List<Widget> imageWidgets =
                        state.episodeDetails.map((show) {
                      String imageUrl = show.episodeBanner!.isNotEmpty
                          ? show.episodeBanner![0]
                          : 'default_image_url';
                      String epiNum = show.episodeId.toString();
                      print("epi num ${epiNum}");
                      return Image.network(imageUrl, fit: BoxFit.cover);
                    }).toList();

                    return HorizontalScrollableCard1(
                      cardStatusColor: Colors.red[300]!,
                      imageListCount: imageWidgets.length,
                      imageList: imageWidgets,
                      textColor: AppColors.white,
                      subtitle: episodeNum,
                      onTap: (String showId, String episodeId) {},
                      titlecard: showNames,
                      showIds: showIds,
                    );
                  } else if (state is UserEpisodeDetailError) {
                    return Text('Error: ${state.message}');
                  } else {
                    return horizontalCardShimmerWidget();
                  }
                },
              ),
            ),
            Padding(
                padding: EdgeInsets.only(left: 18.sp),
                child: Text(AppLocalisation.events,
                    style: AppTestStyle.headingBai(fontSize: 26.sp))),
            Padding(
              padding: EdgeInsets.only(left: 15.sp),
              child: ScrollableElongatedCardWidget(
                cardlength: eventsImagepath.length,
                imageList: eventsImagepath,
                label: eventimagepathtitle,
                sublabel: AppLocalisation.registernowex,
                sublabel1: AppLocalisation.interactwithcreators,
                onPressed: () {},
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.sp, top: 20.sp),
              child: Text(
                AppLocalisation.shareyourthoughts,
                style: AppTestStyle.headingint(
                    fontSize: 20.sp, fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.sp, 15.sp, 0, 10.sp),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: AppColors.black),
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: AppLocalisation.ashwini,
                            style: AppTestStyle.headingint(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w800,
                                color: AppColors.white),
                          ),
                          TextSpan(
                            text: AppLocalisation.sotrue,
                            style: AppTestStyle.headingint(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.white),
                          )
                        ]),
                      )),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.sp, 15.sp, 0, 10.sp),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: AppColors.black),
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: AppLocalisation.glo4life,
                            style: AppTestStyle.headingint(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w800,
                                color: AppColors.white),
                          ),
                          TextSpan(
                            text: AppLocalisation.thanksforsharring,
                            style: AppTestStyle.headingint(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.white),
                          )
                        ]),
                      )),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 15.sp),
              child: Container(
                height: 6.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: AppColors.black),
                ),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween, // Adjust alignment
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: const TextField(
                          decoration: InputDecoration(
                            hintText: 'Comment',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 6.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: AppColors.black),
                        color: AppColors.black, // Background color
                      ),
                      child: InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.sp),
                          child: Center(
                            child: Text(
                              "Send",
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
