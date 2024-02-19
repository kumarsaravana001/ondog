import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ondgo_flutter/bloc/showscreen_bloc/quizDetails_bloc/quizdetail_bloc.dart';
import 'package:ondgo_flutter/utilities/app_banner_list.dart';
import 'package:ondgo_flutter/view/screens/homescreen/widgets/widget.dart';
import '../../../bloc/showscreen_bloc/quizDetails_bloc/quizdetail_event.dart';
import '../../../bloc/showscreen_bloc/quizVisibility_cubit.dart';
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
                    return const CircularProgressIndicator();
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
                        .map((show) => show.episodeId ?? 'No Show Name')
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
                        final int parsedepisodeId =
                            int.tryParse(episodeId) ?? 0;

                        context.read<ShowIdCubit>().updateShowId(parsedShowId);
                        context
                            .read<EpisodeIdCubit>()
                            .updateShowId(parsedepisodeId);

                        BlocProvider.of<QuizDetailsBloc>(context)
                            .add(FetchQuizDetails(
                          showId: int.parse(showId),
                          episodeId: int.parse(episodeId),
                        ));
                        print('Show ID: $showId, Episode ID: $episodeId');
                        context
                            .read<QuizVisibilityCubit>()
                            .toggleQuizVisibility();
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
            Padding(
              padding: EdgeInsets.only(left: 18.sp),
              child: Text(
                AppLocalisation.events,
                style: AppTestStyle.headingBai(fontSize: 26.sp),
              ),
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
