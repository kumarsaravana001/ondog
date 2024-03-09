import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import '../../../bloc/homescreen_bloc/category_wise_show_bloc/category_wise_show_bloc.dart';
import '../../../bloc/homescreen_bloc/popular_picks_bloc/popular_picks_bloc.dart';
import '../../../bloc/homescreen_bloc/popular_picks_bloc/popular_picks_event.dart';
import '../../../bloc/homescreen_bloc/popular_picks_bloc/popular_picks_state.dart';
import '../../../bloc/navigation_cubit/navigationbar_cubit.dart';
import '../../../bloc/search_bloc/catwiseshow_bloc.dart';
import '../../../bloc/search_bloc/catwiseshow_event.dart';
import '../../../bloc/search_bloc/catwiseshow_state.dart';
import '../../../bloc/search_bloc/search_bloc.dart';
import '../../../bloc/search_bloc/search_event.dart';
import '../../../bloc/search_bloc/search_state.dart';
import '../../../bloc/showscreen_bloc/showDetails_bloc/show_details_bloc.dart';
import '../../../bloc/showscreen_bloc/showDetails_bloc/show_details_event.dart';
import '../../../bloc/showscreen_bloc/showEpisodeDetails_bloc/showEpisode_details_bloc.dart';
import '../../../bloc/showscreen_bloc/showEpisodeDetails_bloc/showEpisode_details_event.dart';
import '../../../bloc/showscreen_bloc/showId_cubit.dart';
import '../../../config/config_index.dart';
import '../../../models/search_model/search_model.dart';
import '../../../utilities/app_bg.dart';
import '../../../utilities/app_horizontal_scroll_card.dart';
import '../../../utilities/index.dart';
import '../homescreen/widgets/widget.dart';

class SearchandLibraryScreen extends StatefulWidget {
  const SearchandLibraryScreen({super.key});

  @override
  State<SearchandLibraryScreen> createState() => _SearchandLibraryScreenState();
}

class _SearchandLibraryScreenState extends State<SearchandLibraryScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.addListener(_onSearchChanged);

    final String userId =
        Hive.box('sessionBox').get('userId', defaultValue: '');

    context.read<SearchBloc>().stream.listen(
      (state) {
        if (state is SearchLoaded) {
          if (state.categories.isNotEmpty) {
            final categoryIdStr = state.categories.first.categoryId;
            final categoryId = int.tryParse(categoryIdStr ?? '0');
            if (categoryId != null && categoryId > 0) {
              context.read<CategoryWiseShowSearchBloc>().add(
                  FetchCategoryWiseShowsSearch(
                      categoryId: categoryId, userId: userId));
            }
          }
        }
      },
    );
  }

  void _onSearchChanged() {
    String userId = Hive.box('sessionBox').get('userId', defaultValue: '');
    if (userId.isNotEmpty) {
      context
          .read<SearchBloc>()
          .add(FetchCategories(userId: userId, query: searchController.text));
    }
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CategoryWiseShowBloc>(
            create: (context) => CategoryWiseShowBloc()),
        BlocProvider<PopularPicksBloc>(
            create: (context) => PopularPicksBloc()..add(FetchPopularPicks())),
      ],
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                ClipPath(
                  clipper: Hometopshape1(),
                  child: Stack(
                    children: [
                      Container(
                        height: 30.h,
                        color: AppColors.black,
                      ),
                      // Positioned(
                      //   top: 0,
                      //   right: 30,
                      //   child: Row(
                      //     children: [
                      //       SvgPicture.asset(IconAssets.badgecloseblack)
                      //     ],
                      //   ),
                      // ),
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
                      Padding(
                        padding: EdgeInsets.only(
                            top: 38.sp, left: 20.sp, right: 15.sp),
                        child: CustomTextField(
                          controller: searchController,
                          hintText: "Search",
                          borderColor: AppColors.white,
                          textColor: AppColors.black,
                          suffixIcon: Icons.search,
                          onSuffixIconPressed: () {},
                        ),
                      )
                    ],
                  ),
                ),
                Stack(
                  children: [
                    SvgPicture.asset(IconAssets.spotlightbgframe2,
                        height: 35.h, fit: BoxFit.cover),
                    Positioned(
                      left: 15.sp,
                      right: 5.sp,
                      child: Column(
                        children: [
                          BlocBuilder<SearchBloc, SearchState>(
                            builder: (context, state) {
                              if (state is SearchLoading) {
                                return const CircularProgressIndicator();
                              } else if (state is SearchLoaded) {
                                return buildSearchResults(state.categories);
                              } else if (state is SearchError) {
                                return const Text(
                                    'Failed to load search results');
                              }
                              return Container();
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20.0.sp, top: 10.sp),
                            child: BlocBuilder<CategoryWiseShowSearchBloc,
                                CategoryWiseShowSearchState>(
                              builder: (context, state) {
                                if (state is CategoryWiseShowSearchLoading) {
                                  return const CircularProgressIndicator();
                                } else if (state
                                        is CategoryWiseShowSearchLoaded &&
                                    state.categoryWise.isNotEmpty) {
                                  List<String> showNames = state.categoryWise
                                      .map((show) =>
                                          show.showName ?? 'No Show Name')
                                      .toList();
                                  List<String> showIds = state.categoryWise
                                      .map((show) => show.showId.toString())
                                      .toList();
                                  List<Widget> imageWidgets =
                                      state.categoryWise.map((show) {
                                    String imageUrl = show.thumbnail!.isNotEmpty
                                        ? show.thumbnail![0]
                                        : 'default_image_url';

                                    return Image.network(imageUrl,
                                        fit: BoxFit.cover);
                                  }).toList();

                                  return HorizontalScrollableCard(
                                    cardStatusColor: Colors.brown,
                                    titlecard: showNames,
                                    imageListCount: state.categoryWise.length,
                                    imageList: imageWidgets,
                                    showIds: showIds,
                                    textColor: AppColors.white,
                                    onTap: (showId) {
                                      final int parsedShowId =
                                          int.tryParse(showId) ?? 0;
                                      context
                                          .read<ShowIdCubit>()
                                          .updateShowId(parsedShowId);

                                      // BlocProvider.of<NavigationCubit>(context)
                                      //     .navigateToIndex(3);
                                      context.push("/showcase");
                                      BlocProvider.of<UserShowDetailBloc>(
                                              context)
                                          .add(FetchUserShowDetail(
                                              showId: int.parse(showId)));
                                      BlocProvider.of<UserEpisodeDetailBloc>(
                                              context)
                                          .add(
                                        FetchUserEpisodeDetail(
                                            showId: int.parse(showId)),
                                      );
                                    },
                                  );
                                } else if (state
                                    is CategoryWiseShowSearchError) {
                                  return Text('Error: ${state.message}');
                                } else {
                                  return BlocBuilder<PopularPicksBloc,
                                      PopularPicksState>(
                                    builder: (context, state) {
                                      if (state is PopularPicksLoading) {
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      } else if (state is PopularPicksLoaded &&
                                          state.popularPicks.isNotEmpty) {
                                        List<String> showNames = state
                                            .popularPicks
                                            .map((show) =>
                                                show.showName ?? 'No Show Name')
                                            .toList();
                                        List<String> showIds = state
                                            .popularPicks
                                            .map((show) =>
                                                show.showId ?? 'No Show Name')
                                            .toList();
                                        List<Widget> imageWidgets =
                                            state.popularPicks.map((show) {
                                          String imageUrl =
                                              show.thumbnail!.isNotEmpty
                                                  ? show.thumbnail![0]
                                                  : 'default_image_url';

                                          return Image.network(imageUrl,
                                              fit: BoxFit.cover);
                                        }).toList();

                                        return HorizontalScrollableCard(
                                          titlecard: showNames,
                                          imageListCount:
                                              state.popularPicks.length,
                                          imageList: imageWidgets,
                                          textColor: AppColors.white,
                                          cardStatusColor: Colors.indigoAccent,
                                          onTap: (String showId) {
                                            final int parsedShowId =
                                                int.tryParse(showId) ?? 0;
                                            context
                                                .read<ShowIdCubit>()
                                                .updateShowId(parsedShowId);

                                            // BlocProvider.of<NavigationCubit>(context)
                                            //     .navigateToIndex(3);
                                            context.push("/showcase");
                                            BlocProvider.of<UserShowDetailBloc>(
                                                    context)
                                                .add(FetchUserShowDetail(
                                                    showId: int.parse(showId)));
                                            BlocProvider.of<
                                                        UserEpisodeDetailBloc>(
                                                    context)
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
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSearchResults(List<SearchModelData> categories) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: categories.length,
      itemBuilder: (BuildContext context, int index) {
        SearchModelData category = categories[index];
        return Center(
          child: Text(
            category.categoryName!,
            style: AppTestStyle.headingBai(fontSize: 26.sp),
          ),
        );
      },
    );
  }
}
