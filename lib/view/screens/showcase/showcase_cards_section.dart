import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ondgo_flutter/bloc/showscreen_bloc/episodeVideoDetails_bloc/epidoseVideoDetail_bloc.dart';
import 'package:ondgo_flutter/bloc/showscreen_bloc/quizDetails_bloc/quizdetail_bloc.dart';
import 'package:ondgo_flutter/bloc/showscreen_bloc/showDetails_bloc/show_details_event.dart';
import 'package:ondgo_flutter/utilities/app_banner_list.dart';
import 'package:ondgo_flutter/view/screens/homescreen/widgets/widget.dart';
import '../../../bloc/showscreen_bloc/episodeVideoDetails_bloc/episodeVideoDetail_event.dart';
import '../../../bloc/showscreen_bloc/episodeDisplay_cubit.dart';
import '../../../bloc/showscreen_bloc/quizDetails_bloc/quizdetail_event.dart';
import '../../../bloc/showscreen_bloc/quizVisibility_cubit.dart';
import '../../../bloc/showscreen_bloc/showDetails_bloc/show_details_bloc.dart';
import '../../../bloc/showscreen_bloc/showDetails_bloc/show_details_state.dart';
import '../../../bloc/showscreen_bloc/showEpisodeDetails_bloc/showEpisode_details_bloc.dart';
import '../../../bloc/showscreen_bloc/showEpisodeDetails_bloc/showEpisode_details_event.dart';
import '../../../bloc/showscreen_bloc/showEpisodeDetails_bloc/showEpisode_details_state.dart';
import '../../../bloc/showscreen_bloc/showId_cubit.dart';
import '../../../config/config_index.dart';
import '../../../utilities/app_horizontal_scroll_card.dart';
import '../../../utilities/app_scrollable_elongated_card.dart';

class ShowCaseCardSections extends StatefulWidget {
  const ShowCaseCardSections({
    super.key,
  });

  @override
  State<ShowCaseCardSections> createState() => _ShowCaseCardSectionsState();
}

class _ShowCaseCardSectionsState extends State<ShowCaseCardSections> {
  @override
  void initState() {
    super.initState();
    final showId = context.read<ShowIdCubit>().state;
    if (showId != null) {
      context
          .read<UserShowDetailBloc>()
          .add(FetchUserShowDetail(showId: showId));
    }
  }

  @override
  Widget build(BuildContext context) {
    final showId = context.read<ShowIdCubit>().state;

    return MultiBlocProvider(
      providers: [
        BlocProvider<QuizDetailsBloc>(create: (context) => QuizDetailsBloc()),
        BlocProvider<UserEpisodeDetailBloc>(
            create: (context) => UserEpisodeDetailBloc()
              ..add(FetchUserEpisodeDetail(showId: showId))),
      ],
      child: BlocListener<ShowIdCubit, int?>(
        listener: (context, showId) {
          if (showId != null) {
            context
                .read<UserEpisodeDetailBloc>()
                .add(FetchUserEpisodeDetail(showId: showId));
            context
                .read<UserShowDetailBloc>()
                .add(FetchUserShowDetail(showId: showId));
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 18.sp, right: 25.sp),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Text(
                          AppLocalisation.episodes,
                          style: GoogleFonts.baiJamjuree(
                            color: AppColors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            BlocBuilder<UserShowDetailBloc, UserShowDetailState>(
              builder: (context, state) {
                String episodesText = "Total episodes";
                if (state is UserShowDetailLoaded &&
                    state.userDetails.isNotEmpty) {
                  Object episodesCount =
                      state.userDetails.first.totalEpisodes ?? 0;
                  episodesText += ' ($episodesCount)';
                }

                return Padding(
                  padding: EdgeInsets.only(left: 18.sp),
                  child: Column(
                    children: [
                      Text(
                        episodesText,
                        style: GoogleFonts.baiJamjuree(fontSize: 16.sp),
                      ),
                    ],
                  ),
                );
              },
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.sp),
              child: BlocBuilder<UserEpisodeDetailBloc, UserEpisodeDetailState>(
                builder: (context, state) {
                  if (state is UserEpisodeDetailLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is UserEpisodeDetailLoaded &&
                      state.episodeDetails.isNotEmpty) {
                    List<String> showNames = state.episodeDetails
                        .map((show) => show.showName ?? 'No Show Name')
                        .toList();
                    List<String> showIds = state.episodeDetails
                        .map((show) => show.showId ?? 'No Show Name')
                        .toList();

                    List<String> episodeId = state.episodeDetails
                        .map((show) => show.episodeId ?? 'No Show Name')
                        .toList();
                    List<String> episodeNum = state.episodeDetails
                        .map((show) => show.episodeTitle ?? 'No Show Name')
                        .toList();
                    List<Widget> imageWidgets =
                        state.episodeDetails.map((show) {
                      String imageUrl = show.episodeBanner!.isNotEmpty
                          ? show.episodeBanner![0]
                          : 'default_image_url';
                      return Image.network(imageUrl, fit: BoxFit.cover);
                    }).toList();

                    return HorizontalScrollableCard1(
                      cardStatusColor: Colors.red[300]!,
                      imageListCount: imageWidgets.length,
                      imageList: imageWidgets,
                      textColor: AppColors.white,
                      subtitle: episodeNum,
                      titlecard: showNames,
                      showIds: showIds,
                      episodeId: episodeId,
                      onTap: (String showId, String episodeId) {
                        final int parsedShowId = int.tryParse(showId) ?? 0;
                        final int parsedEpisodeId =
                            int.tryParse(episodeId) ?? 0;
                        print("Show id  ${parsedShowId}");
                        print("Episode id ${parsedEpisodeId}");
                        print("Episode Card OnTapped");
                        context.read<ShowIdCubit>().updateShowId(parsedShowId);
                        context
                            .read<EpisodeIdCubit>()
                            .updateEpisodeId(parsedEpisodeId);

                        context.read<VideoDetailsBloc>().add(
                              FetchVideoDetails(
                                episodeId: parsedEpisodeId,
                                showId: parsedShowId,
                              ),
                            );

                        context.read<QuizDetailsBloc>().add(
                              FetchQuizDetails(
                                showId: parsedShowId,
                                episodeId: parsedEpisodeId,
                              ),
                            );

                        context
                            .read<QuizVisibilityCubit>()
                            .toggleQuizVisibility();
                        context.read<DisplayBloc>().showVideoDetails();
                      },
                    );
                  } else if (state is UserEpisodeDetailError) {
                    return const Center(child: Text("No New Episodes"));
                  } else {
                    return horizontalCardShimmerWidget();
                  }
                },
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.only(left: 18.sp),
            //   child: Text(
            //     AppLocalisation.events,
            //     style: GoogleFonts.baiJamjuree(
            //         fontSize: 26.sp, fontWeight: FontWeight.w700),
            //   ),
            // ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 18.sp, right: 25.sp, top: 20.sp),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Text(
                          AppLocalisation.events,
                          style: GoogleFonts.baiJamjuree(
                            color: AppColors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
              padding: EdgeInsets.only(left: 18.sp, top: 20.sp),
              child: Text(
                AppLocalisation.shareyourthoughts,
                style: GoogleFonts.baiJamjuree(
                    fontSize: 20.sp, fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(18.sp, 15.sp, 0, 10.sp),
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
                            style: AppTextStyle.headingint(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w800,
                                color: AppColors.white),
                          ),
                          TextSpan(
                            text: AppLocalisation.sotrue,
                            style: AppTextStyle.headingint(
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
              padding: EdgeInsets.fromLTRB(18.sp, 8.sp, 30.sp, 10.sp),
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
                            style: AppTextStyle.headingint(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w800,
                                color: AppColors.white),
                          ),
                          TextSpan(
                            text: AppLocalisation.thanksforsharring,
                            style: AppTextStyle.headingint(
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
              padding: EdgeInsets.only(left: 18.sp, right: 25.sp, top: 15.sp),
              child: Container(
                height: 4.h,
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
                                  fontWeight: FontWeight.w600),
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
