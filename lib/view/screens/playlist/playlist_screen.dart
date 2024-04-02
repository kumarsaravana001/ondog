import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ondgo_flutter/bloc/showscreen_bloc/showid_cubit.dart';
import 'package:ondgo_flutter/config/config_index.dart';
import 'package:ondgo_flutter/view/screens/homescreen/widgets/widget.dart';
import '../../../bloc/homescreen_bloc/popular_picks_bloc/popular_picks_bloc.dart';
import '../../../bloc/homescreen_bloc/popular_picks_bloc/popular_picks_event.dart';
import '../../../bloc/homescreen_bloc/popular_picks_bloc/popular_picks_state.dart';
import '../../../bloc/navigation_cubit/navigationbar_cubit.dart';
import '../../../bloc/showscreen_bloc/showDetails_bloc/show_details_bloc.dart';
import '../../../bloc/showscreen_bloc/showDetails_bloc/show_details_event.dart';
import '../../../bloc/showscreen_bloc/showEpisodeDetails_bloc/showEpisode_details_bloc.dart';
import '../../../bloc/showscreen_bloc/showEpisodeDetails_bloc/showEpisode_details_event.dart';
import '../../../utilities/app_horizontal_scroll_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayListScreen extends StatefulWidget {
  const PlayListScreen({super.key});

  @override
  State<PlayListScreen> createState() => _PlayListScreenState();
}

class _PlayListScreenState extends State<PlayListScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PopularPicksBloc>(
          create: (context) => PopularPicksBloc()..add(FetchPopularPicks()),
        ),
        BlocProvider<ShowIdCubit>(
          create: (context) => ShowIdCubit(),
        ),
      ],
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              Positioned(
                bottom: -125,
                left: -10,
                right: 30,
                child: SvgPicture.asset(IconAssets.bottombgdiamond),
              ),
              Column(
                children: [
                  SvgPicture.asset(
                      width: MediaQuery.of(context).size.width,
                      IconAssets.profilescreenbgblack),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      AppLocalisation.yourplaylist,
                      style: GoogleFonts.baiJamjuree(fontSize: 26.sp),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.0.sp, top: 30.sp),
                    child: BlocBuilder<PopularPicksBloc, PopularPicksState>(
                      builder: (context, state) {
                        if (state is PopularPicksLoaded &&
                            state.popularPicks.isNotEmpty) {
                          List<String> showNames = state.popularPicks
                              .map((show) => show.showName ?? 'No Show Name')
                              .toList();
                          List<String> showIds = state.popularPicks
                              .map((show) => show.showId ?? 'No Show Name')
                              .toList();
                          List<Widget> imageWidgets =
                              state.popularPicks.map((show) {
                            String imageUrl = show.thumbnail!.isNotEmpty
                                ? show.thumbnail![0]
                                : 'default_image_url';

                            return Image.network(imageUrl, fit: BoxFit.cover);
                          }).toList();

                          return HorizontalScrollableCard(
                            cardStatusColor: Colors.indigoAccent,
                            titlecard: showNames,
                            imageListCount: state.popularPicks.length,
                            imageList: imageWidgets,
                            textColor: AppColors.white,
                            onTap: (String showId) {
                              final int parsedShowId =
                                  int.tryParse(showId) ?? 0;
                              context
                                  .read<ShowIdCubit>()
                                  .updateShowId(parsedShowId);

                              // BlocProvider.of<NavigationCubit>(context)
                              //     .navigateToIndex(3);
                              context.push("/showcase");
                              BlocProvider.of<UserShowDetailBloc>(context).add(
                                  FetchUserShowDetail(
                                      showId: int.parse(showId)));
                              BlocProvider.of<UserEpisodeDetailBloc>(context)
                                  .add(FetchUserEpisodeDetail(
                                      showId: int.parse(showId)));
                            },
                            showIds: showIds,
                          );
                        } else if (state is PopularPicksLoading) {
                          return horizontalCardShimmerWidget();
                        } else {
                          return horizontalCardShimmerWidget();
                        }
                      },
                    ),
                    //  BlocBuilder<PopularPicksBloc, PopularPicksState>(
                    //   builder: (context, state) {
                    //     if (state is PopularPicksLoading) {
                    //       return const Center(
                    //           child: CircularProgressIndicator());
                    //     } else if (state is PopularPicksLoaded &&
                    //         state.popularPicks.isNotEmpty) {
                    //       List<String> showNames = state.popularPicks
                    //           .map((show) => show.showName ?? 'No Show Name')
                    //           .toList();
                    //       List<String> showIds = state.popularPicks
                    //           .map((show) => show.showId ?? 'No Show Name')
                    //           .toList();
                    //       List<Widget> imageWidgets =
                    //           state.popularPicks.map((show) {
                    //         String imageUrl = show.thumbnail!.isNotEmpty
                    //             ? show.thumbnail![0]
                    //             : 'default_image_url';

                    //         return Image.network(imageUrl, fit: BoxFit.cover);
                    //       }).toList();

                    //       return Column(
                    //         children: [
                    //           HorizontalScrollableCard(
                    //             titlecard: showNames,
                    //             imageListCount: state.popularPicks.length,
                    //             imageList: imageWidgets,
                    //             textColor: AppColors.white,
                    //             cardStatusColor: Colors.indigoAccent,
                    //             onTap: (String showId) {
                    //               final int parsedShowId =
                    //                   int.tryParse(showId) ?? 0;
                    //               context
                    //                   .read<ShowIdCubit>()
                    //                   .updateShowId(parsedShowId);

                    //               BlocProvider.of<NavigationCubit>(context)
                    //                   .navigateToIndex(3);
                    //               BlocProvider.of<UserShowDetailBloc>(context)
                    //                   .add(FetchUserShowDetail(
                    //                       showId: int.parse(showId)));
                    //               BlocProvider.of<UserEpisodeDetailBloc>(
                    //                       context)
                    //                   .add(FetchUserEpisodeDetail(
                    //                       showId: int.parse(showId)));
                    //             },
                    //             showIds: showIds,
                    //           ),
                    //         ],
                    //       );
                    //     } else if (state is PopularPicksLoading) {
                    //       return horizontalCardShimmerWidget();
                    //     } else {
                    //       return horizontalCardShimmerWidget();
                    //     }
                    //   },
                    // ),
                  ),
                ],
              ),
              Positioned(
                top: 0,
                right: 30,
                child: Row(
                  children: [SvgPicture.asset(IconAssets.badgeopen)],
                ),
              ),
              Positioned(
                top: 10,
                left: 20,
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(Icons.arrow_back_outlined,
                          color: AppColors.white, size: 30),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
 //   Expanded(
                                // child: AppVerticalScrollCard1(
                                //   titleCard: showNames,
                                //   imageListCount: state.popularPicks.length,
                                //   imageList: imageWidgets,
                                //   onTap: (String showId) {
                                //     final int parsedShowId =
                                //         int.tryParse(showId) ?? 0;
                                //     context
                                //         .read<ShowIdCubit>()
                                //         .updateShowId(parsedShowId);

                                //     BlocProvider.of<NavigationCubit>(context)
                                //         .navigateToIndex(3);
                                //     BlocProvider.of<UserShowDetailBloc>(context)
                                //         .add(FetchUserShowDetail(
                                //             showId: int.parse(showId)));
                                //     BlocProvider.of<UserEpisodeDetailBloc>(context)
                                //         .add(FetchUserEpisodeDetail(
                                //             showId: int.parse(showId)));
                                //   },
                                //   showIds: showIds,
                                // ),
                                //   )
                                // ],

                                // HorizontalScrollableCard(
                  //   cardStatusColor: Colors.indigo,
                  //   imageListCount: playlistcardnames.length,
                  //   imageList: yourlistImagepath,
                  //   cardbackgroundcolor: AppColors.black,
                  //   textColor: AppColors.white,
                  //   showIds: [],
                  //   onTap: (String showId) {},
                  //   titlecard: [],
                  // ),
                  // Align(
                  //   alignment: Alignment.center,
                  //   child: Text(
                  //     AppLocalisation.videos,
                  //     style: AppTestStyle.headingBai(fontSize: 26.sp),
                  //   ),
                  // ),
                  // HorizontalScrollableCard(
                  //   cardStatusColor: Colors.indigo,
                  //   imageListCount: playlistcardnames.length,
                  //   imageList: yourlistImagepath,
                  //   cardbackgroundcolor: AppColors.black,
                  //   textColor: AppColors.white,
                  //   showIds: [],
                  //   onTap: (String showId) {},
                  //   titlecard: [],
                  // )