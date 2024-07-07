// ignore_for_file: deprecated_member_use
import 'dart:async';
import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:ondgo_flutter/bloc/homescreen_bloc/banner_bloc/homescreen_banner_bloc.dart';
import 'package:ondgo_flutter/bloc/homescreen_bloc/banner_bloc/homescreen_banner_event.dart';
import 'package:ondgo_flutter/bloc/homescreen_bloc/banner_bloc/homescreen_banner_state.dart';
import 'package:ondgo_flutter/bloc/homescreen_bloc/category_list_bloc/category_list_bloc.dart';
import 'package:ondgo_flutter/bloc/homescreen_bloc/category_list_bloc/category_list_event.dart';
import 'package:ondgo_flutter/bloc/homescreen_bloc/category_list_bloc/category_list_state.dart';
import 'package:ondgo_flutter/bloc/homescreen_bloc/category_wise_show_bloc/category_wise_show_event.dart';
import 'package:ondgo_flutter/bloc/homescreen_bloc/popular_picks_bloc/popular_picks_bloc.dart';
import 'package:ondgo_flutter/bloc/homescreen_bloc/popular_picks_bloc/popular_picks_event.dart';
import 'package:ondgo_flutter/bloc/homescreen_bloc/popular_picks_bloc/popular_picks_state.dart';
import 'package:ondgo_flutter/bloc/showscreen_bloc/showEpisodeDetails_bloc/showEpisode_details_bloc.dart';
import 'package:ondgo_flutter/bloc/showscreen_bloc/showEpisodeDetails_bloc/showEpisode_details_event.dart';
import 'package:ondgo_flutter/bloc/showscreen_bloc/showId_cubit.dart';
import 'package:ondgo_flutter/config/config_index.dart';
import 'package:ondgo_flutter/utilities/app_bg.dart';
import 'package:ondgo_flutter/view/screens/homescreen/widgets/widget.dart';
import 'package:shimmer/shimmer.dart';
import '../../../bloc/homescreen_bloc/category_wise_show_bloc/category_wise_show_bloc.dart';
import '../../../bloc/homescreen_bloc/category_wise_show_bloc/category_wise_show_state.dart';
import '../../../bloc/homescreen_bloc/spotlight_bloc/spotlight_bloc.dart';
import '../../../bloc/homescreen_bloc/spotlight_bloc/spotlight_event.dart';
import '../../../bloc/homescreen_bloc/spotlight_bloc/spotlight_state.dart';
import '../../../bloc/showscreen_bloc/showDetails_bloc/show_details_bloc.dart';
import '../../../bloc/showscreen_bloc/showDetails_bloc/show_details_event.dart';
import '../../../utilities/app_horizontal_scroll_card.dart';
import '../../../utilities/index.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> categoryList = [];
  Timer? connectivityCheckTimer;
  late StreamSubscription connectivitySubscription;
  bool isOnline = true;
  List<String> popularPicks = [];
  int? selectedCategoryId;
  List<String> showNames = [];
  String? userId;

  int _currentCarouselIndex = 0;

  @override
  void dispose() {
    connectivitySubscription.cancel();
    connectivityCheckTimer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadUserId();
    monitorNetworkStatus();
    if (isOnline) {
      // _loadData();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No Internet Connection')),
      );
    }
  }

  void monitorNetworkStatus() {
    connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      bool previousStatus = isOnline;
      setState(() {
        isOnline = (result != ConnectivityResult.none);
      });

      if (isOnline && !previousStatus) {
        // Internet was reconnected
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Internet Connection Restored')));
        // _loadData();
        connectivityCheckTimer?.cancel(); // Stop checking for connectivity
      } else if (!isOnline && previousStatus) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No Internet Connection')));
        startConnectivityCheck(); // Start periodic check for connectivity
      }
    });
  }

  void startConnectivityCheck() {
    connectivityCheckTimer?.cancel();
    connectivityCheckTimer =
        Timer.periodic(const Duration(seconds: 10), (timer) async {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult != ConnectivityResult.none) {
        isOnline = true;
        // _loadData();
        connectivityCheckTimer?.cancel();
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Internet Connection Restored')));
      }
    });
  }

  // void _loadData() {
  //   BlocProvider.of<HomeScreenBannerBloc>(context).add(FetchBanners());
  //   BlocProvider.of<PopularPicksBloc>(context).add(FetchPopularPicks());
  //   BlocProvider.of<CategoryListBloc>(context).add(FetchCategoryList());
  //   BlocProvider.of<HomeScreenSpotLightBloc>(context).add(FetchSpotlight());
  // }

  void _loadUserId() async {
    var box = Hive.box('sessionBox');
    userId = box.get('userId');
    if (userId == null) {
      // Handle user not found scenario, maybe navigate to login screen
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeScreenBannerBloc>(
            create: (context) => HomeScreenBannerBloc()..add(FetchBanners())),
        BlocProvider<PopularPicksBloc>(
            create: (context) => PopularPicksBloc()..add(FetchPopularPicks())),
        BlocProvider<CategoryListBloc>(
            create: (context) => CategoryListBloc()..add(FetchCategoryList())),
        BlocProvider<HomeScreenSpotLightBloc>(
            create: (context) =>
                HomeScreenSpotLightBloc()..add(FetchSpotlight())),
        BlocProvider<CategoryWiseShowBloc>(
            create: (context) => CategoryWiseShowBloc()),
        BlocProvider<CategoryWiseShowBloc1>(
            create: (context) => CategoryWiseShowBloc1()),
        BlocProvider<CategoryWiseShowBloc2>(
            create: (context) => CategoryWiseShowBloc2()),
        BlocProvider<UserShowDetailBloc>(
            create: (context) => UserShowDetailBloc()),
        BlocProvider<UserEpisodeDetailBloc>(
            create: (context) => UserEpisodeDetailBloc()),
      ],
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    ClipPath(
                      clipper: Hometopshape(),
                      child: Container(height: 110.h, color: Colors.black),
                    ),
                    Positioned(
                      bottom: 76.sp,
                      left: 48.sp,
                      child: Text(
                        AppLocalisation.spotlight,
                        style: GoogleFonts.baiJamjuree(
                            fontSize: 22.sp,
                            color: AppColors.white,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    Positioned(
                      bottom: 45.sp,
                      left: 13.sp,
                      right: 8.sp,
                      child: SizedBox(
                        child: BlocBuilder<HomeScreenSpotLightBloc,
                            HomeScreenSpotlightState>(
                          builder: (context, state) {
                            if (state is HomeScreenSpotlightLoaded &&
                                state.spotlight.isNotEmpty) {
                              List<String> showNames = state.spotlight
                                  .map(
                                      (show) => show.showName ?? 'No Show Name')
                                  .toList();
                              List<String> showIds = state.spotlight
                                  .map((show) => show.showId ?? 'No Show Name')
                                  .toList();
                              List<Widget> imageWidgets =
                                  state.spotlight.map((show) {
                                String imageUrl = show.thumbnail!.isNotEmpty
                                    ? show.thumbnail![0]
                                    : 'health_care_banner';

                                return Image.network(imageUrl,
                                    fit: BoxFit.cover);
                              }).toList();

                              return HorizontalScrollableCard(
                                cardStatusColor: Colors.indigoAccent,
                                titlecard: showNames,
                                imageListCount: state.spotlight.length,
                                imageList: imageWidgets,
                                textColor: AppColors.black,
                                cardbackgroundcolor: AppColors.white,
                                onTap: (String showId) {
                                  final int parsedShowId =
                                      int.tryParse(showId) ?? 0;

                                  context
                                      .read<ShowIdCubit>()
                                      .updateShowId(parsedShowId);

                                  // BlocProvider.of<UserShowDetailBloc>(context)
                                  //     .add(FetchUserShowDetail(
                                  //         showId: int.parse(showId)));
                                  // BlocProvider.of<UserEpisodeDetailBloc>(
                                  //         context)
                                  //     .add(FetchUserEpisodeDetail(
                                  //         showId: int.parse(showId)));
                                  context.push("/showcase");
                                },
                                showIds: showIds,
                              );
                            } else if (state is HomeScreenSpotlightLoading) {
                              return horizontalCardShimmerWidget();
                            } else {
                              return horizontalCardShimmerWidget();
                            }
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      child: ClipPath(
                        clipper: StackHometopshape(),
                        child: Stack(
                          children: [
                            BlocBuilder<HomeScreenBannerBloc,
                                HomeScreenBannerState>(
                              builder: (context, state) {
                                if (state is HomeScreenBannerLoaded &&
                                    state.banners.isNotEmpty) {
                                  List<Widget> bannerWidgets =
                                      state.banners.expand(
                                    (banner) {
                                      List<String> imageUrls =
                                          banner.thumbnail != null &&
                                                  banner.thumbnail!.isNotEmpty
                                              ? banner.thumbnail!
                                              : [
                                                  'assets/images/middleclass_banner.png'
                                                ];

                                      showNames.add(banner.categoryName ??
                                          'Default Banner');

                                      String showId =
                                          banner.showId ?? 'No Show Name';

                                      return imageUrls.map(
                                        (imageUrl) {
                                          return GestureDetector(
                                            onTap: () {
                                              final int parsedShowId =
                                                  int.tryParse(showId) ?? 0;
                                              context
                                                  .read<ShowIdCubit>()
                                                  .updateShowId(parsedShowId);
                                              // BlocProvider.of<NavigationCubit>(
                                              //         context)
                                              //     .navigateToIndex(3);
                                              context.push("/showcase");
                                              // BlocProvider.of<
                                              //             UserShowDetailBloc>(
                                              //         context)
                                              //     .add(FetchUserShowDetail(
                                              //         showId:
                                              //             int.parse(showId)));
                                            },
                                            child: Image.network(
                                              imageUrl,
                                              fit: BoxFit.fill,
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ).toList();
                                  return SizedBox(
                                    height: 64.h,
                                    child: CarouselSlider(
                                      items: bannerWidgets,
                                      options: CarouselOptions(
                                        autoPlay: true,
                                        autoPlayCurve: Curves.decelerate,
                                        autoPlayInterval:
                                            const Duration(seconds: 5),
                                        height: 64.h,
                                        viewportFraction: 1.0,
                                        onPageChanged: (index, reason) {
                                          setState(() {
                                            _currentCarouselIndex = index;
                                          });
                                        },
                                      ),
                                    ),
                                  );
                                } else if (state is HomeScreenBannerLoading) {
                                  return buildbannerShimmerEffect();
                                } else {
                                  return buildbannerShimmerEffect();
                                }
                              },
                            ),
                            Container(
                              // height: 5.h,
                              color: AppColors.black,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 18.sp, top: 8.sp, bottom: 8.sp),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: SvgPicture.asset(
                                      IconAssets.ondgoTextlogoblackcovered,
                                      height: 26.sp,
                                      semanticsLabel: 'Ondgo Logo'),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 22.sp,
                              right: 22.sp,
                              child:
                                  SvgPicture.asset(IconAssets.badgecloseblack),
                            ),
                            // Row(
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   children: [
                            //     Expanded(
                            //       flex: 6,
                            //       child: Container(
                            //         height: 5.h,
                            //         color: AppColors.black,
                            //         child: Padding(
                            //           padding: const EdgeInsets.all(8.0),
                            //           child: Align(
                            //             alignment: Alignment.topLeft,
                            //             child: SvgPicture.asset(
                            //                 IconAssets
                            //                     .ondgoTextlogoblackcovered,
                            //                 height: 22.sp,
                            //                 semanticsLabel: 'Ondgo Logo'),
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //     Column(
                            //       children: [
                            //         Container(
                            //             color: AppColors.black,
                            //             height: 2.h,
                            //             child: Container()),
                            //         SvgPicture.asset(
                            //             IconAssets.badgecloseblack),
                            //       ],
                            //     ),
                            //     Expanded(
                            //       flex: 2,
                            //       child: Container(
                            //         height: 5.h,
                            //         color: AppColors.black,
                            //       ),
                            //     ),
                            //   ],
                            // ),

                            // Positioned(
                            //   top: 8,
                            //   left: 30,
                            //   child: SvgPicture.asset(
                            //       IconAssets.ondgoTextlogoblackcovered,
                            //       height: 26.sp,
                            //       semanticsLabel: 'Ondgo Logo'),
                            // ),
                            // Positioned(
                            //   top: 0,
                            //   right: 30,
                            //   child: InkWell(
                            //     onTap: () {},
                            //     child: SvgPicture.asset(
                            //         IconAssets.badgecloseblack),
                            //   ),
                            // ),

                            Positioned(
                              top: 75.sp,
                              child: Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 20.sp),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomElevatedButton(
                                            backgroundcolor: AppColors.black,
                                            bordercolor: AppColors.white,
                                            fontsize: 16.sp,
                                            labelcolor: AppColors.white,
                                            onPressed: () {},
                                            text: 'Stream Now'),
                                        SizedBox(width: 40.w),
                                        Container(
                                            height: 4.5.h,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppColors.black,
                                              border: Border.all(
                                                  color: AppColors.white),
                                            ),
                                            child: IconButton(
                                              icon: const Icon(
                                                Icons.search,
                                                color: AppColors.white,
                                                size: 16,
                                              ),
                                              onPressed: () {
                                                context.push("/search");
                                              },
                                            )
                                            // const Icon(Icons.search,
                                            //     color: AppColors.white),
                                            )
                                      ],
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.black.withOpacity(0.95),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 10.sp,
                                            right: 10.sp,
                                            bottom: 3.sp),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            BlocBuilder<HomeScreenBannerBloc,
                                                HomeScreenBannerState>(
                                              builder: (context, state) {
                                                if (state
                                                        is HomeScreenBannerLoaded &&
                                                    state.banners.isNotEmpty) {
                                                  showNames = state.banners
                                                      .map((banner) =>
                                                          banner.categoryName ??
                                                          'Default Banner')
                                                      .toList();

                                                  return Text(
                                                    _currentCarouselIndex <
                                                            showNames.length
                                                        ? showNames[
                                                            _currentCarouselIndex]
                                                        : 'Show loading',
                                                    style:
                                                        GoogleFonts.baiJamjuree(
                                                      fontSize: 24.sp,
                                                      color: AppColors.white,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  );
                                                } else if (state
                                                    is HomeScreenBannerLoading) {
                                                  return Shimmer.fromColors(
                                                      baseColor:
                                                          Colors.grey[300]!,
                                                      highlightColor:
                                                          Colors.grey[100]!,
                                                      child: Container(
                                                        height: 6.h,
                                                      ));
                                                  //buildbannerShimmerEffect();
                                                } else {
                                                  return Container();
                                                }
                                              },
                                            ),
                                            Text(
                                              AppLocalisation.newepisodes,
                                              style: AppTextStyle.headingint(
                                                fontSize: 18.sp,
                                                color: AppColors.white,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              right: 60,
                              left: 60,
                              child: SvgPicture.asset(
                                  IconAssets.diamondstar, //do later
                                  height: 15,
                                  color: _currentCarouselIndex == 0
                                      ? Colors.white
                                      : Colors.grey),
                            ),
                            Positioned(
                              bottom: 20,
                              right: 1,
                              left: 60,
                              child: SvgPicture.asset(
                                IconAssets.diamondstar,
                                height: 15,
                                color: _currentCarouselIndex == 1
                                    ? Colors.white
                                    : Colors.grey,
                              ),
                            ),
                            Positioned(
                              bottom: 20,
                              right: 60,
                              left: 1,
                              child: SvgPicture.asset(
                                IconAssets.diamondstar,
                                height: 15,
                                color: _currentCarouselIndex == 2
                                    ? Colors.white
                                    : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(bottom: 22.sp),
                        child: SvgPicture.asset(IconAssets.appbackground)),
                    Center(
                      child: Text(AppLocalisation.popularpicks,
                          style: GoogleFonts.baiJamjuree(
                              fontSize: 22.sp,
                              color: AppColors.black,
                              fontWeight: FontWeight.w800)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 12.0.sp, top: 30.sp),
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
                                  : 'health_care_banner';

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
                                // BlocProvider.of<UserShowDetailBloc>(context)
                                //     .add(FetchUserShowDetail(
                                //         showId: int.parse(showId)));
                                // BlocProvider.of<UserEpisodeDetailBloc>(context)
                                //     .add(FetchUserEpisodeDetail(
                                //         showId: int.parse(showId)));
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
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 22.sp),
                      child: SvgPicture.asset(IconAssets.appbackground),
                    ),
                    Center(
                      child: BlocListener<CategoryListBloc, CategoryListState>(
                        listener: (context, state) {
                          // if (state is CategoryListLoaded) {
                          //   if (state.categories.isNotEmpty) {
                          //     final categoryIdStr =
                          //         state.categories.first.categoryId;
                          //     final categoryId =
                          //         int.tryParse(categoryIdStr ?? '0');
                          //     if (categoryId != null && categoryId > 0) {
                          //       context.read<CategoryWiseShowBloc>().add(
                          //           FetchCategoryWiseShows(
                          //               categoryId: categoryId));
                          //     }
                          //   }
                          // }
                          if (state is CategoryListLoaded &&
                              state.categories.isNotEmpty) {
                            int categoryId =
                                int.parse(state.categories[0].categoryId!);
                            BlocProvider.of<CategoryWiseShowBloc>(context).add(
                              FetchCategoryWiseShows(categoryId: categoryId),
                            );
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: 13.sp),
                          child: Center(
                            child: BlocBuilder<CategoryListBloc,
                                CategoryListState>(
                              builder: (context, state) {
                                if (state is CategoryListLoaded &&
                                    state.categories.isNotEmpty) {
                                  return Text(
                                    state.categories[0].categoryName ??
                                        'Default Category Name',
                                    style: GoogleFonts.baiJamjuree(
                                        fontSize: 22.sp,
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w800),
                                  );
                                } else {
                                  return buildTextShimmerEffect();
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 12.0.sp, top: 30.sp),
                      child: BlocBuilder<CategoryWiseShowBloc,
                          CategoryWiseShowState>(
                        builder: (context, state) {
                          if (state is CategoryWiseShowLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (state is CategoryWiseShowLoaded &&
                              state.shows.isNotEmpty) {
                            List<String> showNames = state.shows
                                .map((show) => show.showName ?? 'No Show Name')
                                .toList();
                            List<String> showIds = state.shows
                                .map((show) => show.showId.toString())
                                .toList();
                            List<Widget> imageWidgets = state.shows.map((show) {
                              String imageUrl = show.thumbnail!.isNotEmpty
                                  ? show.thumbnail![0]
                                  : 'health_care_banner';

                              return Image.network(imageUrl, fit: BoxFit.cover);
                            }).toList();

                            return HorizontalScrollableCard(
                              cardStatusColor: Colors.brown,
                              titlecard: showNames,
                              imageListCount: state.shows.length,
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
                                // BlocProvider.of<UserShowDetailBloc>(context)
                                //     .add(FetchUserShowDetail(
                                //         showId: int.parse(showId)));
                                // BlocProvider.of<UserEpisodeDetailBloc>(context)
                                //     .add(
                                //   FetchUserEpisodeDetail(
                                //       showId: int.parse(showId)),
                                // );
                              },
                            );
                          } else if (state is CategoryWiseShowError) {
                            return Text('Error: ${state.message}');
                          } else {
                            return horizontalCardShimmerWidget();
                          }
                        },
                      ),
                    )
                  ],
                ),
                Stack(
                  children: [
                    SvgPicture.asset(IconAssets.appbackground),
                    Center(
                      child: BlocListener<CategoryListBloc, CategoryListState>(
                        listener: (context, state) {
                          if (state is CategoryListLoaded &&
                              state.categories.isNotEmpty) {
                            int categoryIdd =
                                int.parse(state.categories[1].categoryId!);
                            BlocProvider.of<CategoryWiseShowBloc1>(context).add(
                                FetchCategoryWiseShows1(
                                    categoryIdd: categoryIdd));
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: 13.sp),
                          child: Center(
                            child: BlocBuilder<CategoryListBloc,
                                CategoryListState>(
                              builder: (context, state) {
                                if (state is CategoryListLoaded &&
                                    state.categories.isNotEmpty) {
                                  return Text(
                                    state.categories[1].categoryName ??
                                        'Default Category Name',
                                    style: GoogleFonts.baiJamjuree(
                                        fontSize: 22.sp,
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w800),
                                  );
                                } else {
                                  return buildTextShimmerEffect();
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 12.0.sp, top: 30.sp),
                      child: BlocBuilder<CategoryWiseShowBloc1,
                          CategoryWiseShow1State>(
                        builder: (context, state) {
                          if (state is CategoryWiseShow1Loading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (state is CategoryWiseShow1Loaded &&
                              state.shows.isNotEmpty) {
                            List<String> showNames = state.shows
                                .map((show) => show.showName ?? 'No Show Name')
                                .toList();
                            List<String> showIds = state.shows
                                .map((show) => show.showId ?? 'No Show Name')
                                .toList();
                            List<Widget> imageWidgets = state.shows.map((show) {
                              String imageUrl = show.thumbnail!.isNotEmpty
                                  ? show.thumbnail![0]
                                  : 'health_care_banner';

                              return Image.network(imageUrl, fit: BoxFit.cover);
                            }).toList();

                            return HorizontalScrollableCard(
                              cardStatusColor: Colors.amberAccent,
                              titlecard: showNames,
                              imageListCount: state.shows.length,
                              imageList: imageWidgets,
                              showIds: showIds,
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
                                // BlocProvider.of<UserShowDetailBloc>(context)
                                //     .add(FetchUserShowDetail(
                                //         showId: int.parse(showId)));
                                // BlocProvider.of<UserEpisodeDetailBloc>(context)
                                //     .add(FetchUserEpisodeDetail(
                                //         showId: int.parse(showId)));
                              },
                            );
                          } else if (state is CategoryWiseShow1Error) {
                            return Text('Error: ${state.messages}');
                          } else {
                            return horizontalCardShimmerWidget();
                          }
                        },
                      ),
                    )
                  ],
                ),
                Stack(
                  children: [
                    SvgPicture.asset(IconAssets.appbackground),
                    Center(
                      child: BlocListener<CategoryListBloc, CategoryListState>(
                        listener: (context, state) {
                          if (state is CategoryListLoaded &&
                              state.categories.isNotEmpty) {
                            int categoryIddd =
                                int.parse(state.categories[2].categoryId!);
                            BlocProvider.of<CategoryWiseShowBloc2>(context).add(
                              FetchCategoryWiseShows2(
                                  categoryIddd: categoryIddd),
                            );
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: 13.sp),
                          child: Center(
                            child: BlocBuilder<CategoryListBloc,
                                CategoryListState>(
                              builder: (context, state) {
                                if (state is CategoryListLoaded &&
                                    state.categories.isNotEmpty) {
                                  return Text(
                                    state.categories[2].categoryName ??
                                        'Default Category Name',
                                    style: GoogleFonts.baiJamjuree(
                                        fontSize: 22.sp,
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w800),
                                  );
                                } else {
                                  return buildTextShimmerEffect();
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 12.0.sp, top: 30.sp),
                      child: BlocBuilder<CategoryWiseShowBloc2,
                          CategoryWiseShow2State>(
                        builder: (context, state) {
                          if (state is CategoryWiseShow2Loading) {
                            return const Center(
                                child: Center(
                                    child:
                                        CircularProgressIndicator())); // Show loading indicator while data is being fetched
                          } else if (state is CategoryWiseShow2Loaded &&
                              state.shows.isNotEmpty) {
                            // Extracting show names and thumbnails from the loaded shows
                            List<String> showNames = state.shows
                                .map((show) => show.showName ?? 'No Show Name')
                                .toList();
                            List<String> showIds = state.shows
                                .map((show) => show.showId ?? 'No Show Name')
                                .toList();
                            List<Widget> imageWidgets = state.shows.map((show) {
                              String imageUrl = show.thumbnail!.isNotEmpty
                                  ? show.thumbnail![0]
                                  : 'health_care_banner';

                              return Image.network(imageUrl, fit: BoxFit.cover);
                            }).toList();

                            return HorizontalScrollableCard(
                              cardStatusColor: Colors.green,
                              titlecard: showNames,
                              imageListCount: state.shows.length,
                              imageList: imageWidgets,
                              showIds: showIds,
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
                                // BlocProvider.of<UserShowDetailBloc>(context)
                                //     .add(FetchUserShowDetail(
                                //         showId: int.parse(showId)));
                                // BlocProvider.of<UserEpisodeDetailBloc>(context)
                                //     .add(FetchUserEpisodeDetail(
                                //         showId: int.parse(showId)));
                              },
                            );
                          } else if (state is CategoryWiseShow2Error) {
                            return Text('Error: ${state.messages}');
                          } else {
                            return horizontalCardShimmerWidget();
                          }
                        },
                      ),
                    )
                  ],
                ),
                SizedBox(height: 12.h)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
