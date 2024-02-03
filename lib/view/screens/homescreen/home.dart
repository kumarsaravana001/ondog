import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:ondgo_flutter/config/config_index.dart';
import 'package:ondgo_flutter/models/homescreen_model/banner_model.dart';
import 'package:ondgo_flutter/models/homescreen_model/popular_picks_model.dart';
import 'package:ondgo_flutter/utilities/app_banner_list.dart';
import 'package:ondgo_flutter/utilities/app_bg.dart';
import 'package:ondgo_flutter/view/screens/homescreen/widgets/widget.dart';
import '../../../bloc/homescreen_bloc/category_wise_show_bloc/category_wise_show_bloc.dart';
import '../../../bloc/homescreen_bloc/category_wise_show_bloc/category_wise_show_state.dart';
import '../../../utilities/app_horizontal_scroll_card.dart';
import '../../../utilities/index.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> categoryList = [];
  late StreamSubscription connectivitySubscription;
  bool isOnline = true;
  List<String> popularPicks = [];
  int? selectedCategoryId;
  List<String> showNames = [];
  String? userId;
  Timer? connectivityCheckTimer;

  int _currentCarouselIndex = 0;

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
        _loadData();
        connectivityCheckTimer?.cancel(); // Stop checking for connectivity
      } else if (!isOnline && previousStatus) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('No Internet Connection')));
        startConnectivityCheck(); // Start periodic check for connectivity
      }
    });
  }

  void startConnectivityCheck() {
    connectivityCheckTimer?.cancel(); // Cancel any existing timer
    connectivityCheckTimer =
        Timer.periodic(const Duration(seconds: 10), (timer) async {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult != ConnectivityResult.none) {
        isOnline = true;
        _loadData();
        connectivityCheckTimer?.cancel(); // Stop the timer as internet is back
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Internet Connection Restored')));
      }
    });
  }

  void _loadData() {
    // Triggering the fetching of data for each relevant BLoC
    BlocProvider.of<HomeScreenBannerBloc>(context).add(FetchBanners());
    BlocProvider.of<PopularPicksBloc>(context).add(FetchPopularPicks());
    BlocProvider.of<CategoryListBloc>(context).add(FetchCategoryList());
    // Add other BLoC fetch events here as needed
  }

  HorizontalScrollableCard popularPicksWidget(
      List<PopularpicksData> popularpicks) {
    List<String> imageUrls = [];
    List<String> showNames = [];
    for (var pick in popularpicks) {
      String imageUrl = pick.thumbnail != null && pick.thumbnail!.isNotEmpty
          ? pick.thumbnail!.first
          : 'default_image_url';
      imageUrls.add(imageUrl);
      showNames.add(pick.showName ?? 'Default Show Name');
    }

    List<Image> imageWidgets = imageUrls.map((url) {
      return Image.network(url, fit: BoxFit.cover);
    }).toList();

    return HorizontalScrollableCard(
      cardStatusColor: Colors.indigoAccent,
      titlecard: showNames,
      imageListCount: popularpicks.length,
      imageList: imageWidgets,
      textColor: AppColors.white,
    );
  }

  Widget buildBannerCarousel(List<Data> banners) {
    List<Widget> bannerWidgets = banners.expand((banner) {
      List<String> imageUrls =
          banner.thumbnail != null && banner.thumbnail!.isNotEmpty
              ? banner.thumbnail!
              : ['assets/images/middleclass_banner.png'];

      showNames.add(banner.categoryName ?? 'Default Banner');

      return imageUrls.map((imageUrl) {
        return Image.network(imageUrl, fit: BoxFit.cover);
      });
    }).toList();
    return SizedBox(
      height: 71.h,
      child: CarouselSlider(
        items: bannerWidgets,
        options: CarouselOptions(
          autoPlay: true,
          autoPlayCurve: Curves.decelerate,
          autoPlayInterval: const Duration(seconds: 5),
          height: 71.h,
          viewportFraction: 1.0,
          onPageChanged: (index, reason) {
            setState(() {
              _currentCarouselIndex = index;
            });
          },
        ),
      ),
    );
  }

  void _loadUserId() async {
    var box = Hive.box('sessionBox');
    userId = box.get('userId');
    if (userId == null) {
      // Handle user not found scenario, maybe navigate to login screen
    } else {
      // Make your API calls using userId
    }
  }

  @override
  void dispose() {
    connectivitySubscription.cancel();
    connectivityCheckTimer?.cancel();
    super.dispose();
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
          create: (context) => CategoryListBloc()..add(FetchCategoryList()),
        ),
        BlocProvider<CategoryWiseShowBloc>(
            create: (context) => CategoryWiseShowBloc()),
        BlocProvider<CategoryWiseShowBloc1>(
            create: (context) => CategoryWiseShowBloc1()),
        BlocProvider<CategoryWiseShowBloc2>(
            create: (context) => CategoryWiseShowBloc2()),
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
                      child: Container(
                        height: 122.h,
                        color: Colors.black,
                      ),
                    ),
                    Positioned(
                        bottom: 80.sp,
                        right: 46.sp,
                        child: Text(AppLocalisation.spotlight,
                            style: AppTestStyle.headingBai(
                                fontSize: 22.sp,
                                color: AppColors.white,
                                fontWeight: FontWeight.w700))),
                    Positioned(
                      bottom: 50.sp,
                      left: 20.sp,
                      right: 8.sp,
                      child: SizedBox(
                        height: 200,
                        child: HorizontalScrollableCard1(
                          cardStatusColor: Colors.indigo,
                          imageListCount: playlistcardnames.length,
                          imageList: yourlistImagepath,
                          cardbackgroundcolor: AppColors.white,
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
                                if (state is HomeScreenBannerLoaded) {
                                  return buildBannerCarousel(state.banners);
                                } else if (state is HomeScreenBannerLoading) {
                                  return buildbannerShimmerEffect();
                                } else {
                                  return buildbannerShimmerEffect();
                                }
                              },
                            ),
                            Positioned(
                              top: 8,
                              left: 30,
                              child: SvgPicture.asset(
                                  IconAssets.ondgoTextlogoblackcovered,
                                  height: 24.sp,
                                  semanticsLabel: 'Ondgo Logo'),
                            ),
                            Positioned(
                              top: 0,
                              right: 30,
                              child: InkWell(
                                onTap: () {},
                                child: SvgPicture.asset(
                                    IconAssets.badgecloseblack),
                              ),
                            ),
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
                                            fontsize: 13,
                                            labelcolor: AppColors.white,
                                            onPressed: () {},
                                            text: 'streaming soon'),
                                        SizedBox(width: 50.w),
                                        Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppColors.black,
                                              border: Border.all(
                                                  color: AppColors.white),
                                            ),
                                            child: const Icon(Icons.add,
                                                color: AppColors.white))
                                      ],
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.white60),
                                      child: Padding(
                                        padding: EdgeInsets.all(10.sp),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              _currentCarouselIndex <
                                                      showNames.length
                                                  ? showNames[
                                                      _currentCarouselIndex]
                                                  : 'Show',
                                              style: AppTestStyle.headingBai(
                                                fontSize: 24.sp,
                                                color: AppColors.black,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              AppLocalisation.newepisodes,
                                              style: AppTestStyle.headingint(
                                                fontSize: 18.sp,
                                                color: AppColors.black,
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
                                    height: 14,
                                    // ignore: deprecated_member_use
                                    color: _currentCarouselIndex == 0
                                        ? Colors.white
                                        : Colors.grey)),
                            Positioned(
                                bottom: 20,
                                right: 1,
                                left: 60,
                                child: SvgPicture.asset(
                                  IconAssets.diamondstar,
                                  height: 14,
                                  // ignore: deprecated_member_use
                                  color: _currentCarouselIndex == 1
                                      ? Colors.white
                                      : Colors.grey,
                                )),
                            Positioned(
                              bottom: 20,
                              right: 60,
                              left: 1,
                              child: SvgPicture.asset(
                                IconAssets.diamondstar,
                                height: 14,
                                // ignore: deprecated_member_use
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
                          style: AppTestStyle.headingBai(
                              fontSize: 22.sp,
                              color: AppColors.black,
                              fontWeight: FontWeight.w800)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.0.sp, top: 30.sp),
                      child: BlocBuilder<PopularPicksBloc, PopularPicksState>(
                        builder: (context, state) {
                          if (state is PopularPicksLoaded) {
                            return popularPicksWidget(state.popularPicks);
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
                          if (state is CategoryListLoaded &&
                              state.categories.isNotEmpty) {
                            int categoryId =
                                int.parse(state.categories[0].categoryId!);
                            BlocProvider.of<CategoryWiseShowBloc>(context).add(
                                FetchCategoryWiseShows(categoryId: categoryId));

                            print("inside bloclistner 1 ${categoryId}");
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
                                    style: AppTestStyle.headingBai(
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
                      padding: EdgeInsets.only(left: 20.0.sp, top: 30.sp),
                      child: BlocBuilder<CategoryWiseShowBloc,
                          CategoryWiseShowState>(
                        builder: (context, state) {
                          if (state is CategoryWiseShowLoading) {
                            return const CircularProgressIndicator();
                          } else if (state is CategoryWiseShowLoaded &&
                              state.shows.isNotEmpty) {
                            List<String> showNames = state.shows
                                .map((show) => show.showName ?? 'No Show Name')
                                .toList();
                            // print(
                            //     "inside blocBuilder Showwise 1  ${showNames}");
                            List<Widget> imageWidgets = state.shows.map((show) {
                              String imageUrl = show.thumbnail!.isNotEmpty
                                  ? show.thumbnail![0]
                                  : 'default_image_url';
                              // print(
                              //     "inside blocBuilder Showwise 1 ${imageUrl}");
                              return Image.network(imageUrl, fit: BoxFit.cover);
                            }).toList();

                            return HorizontalScrollableCard(
                              cardStatusColor: Colors.brown,
                              titlecard: showNames,
                              imageListCount: state.shows.length,
                              imageList: imageWidgets,
                              textColor: AppColors.white,
                            );
                          } else if (state is CategoryWiseShowError) {
                            return Text('Error: ${state.message}');
                          } else {
                            return horizontalCardShimmerWidget(); // Or handle other states as needed
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

                            print("inside bloclistner 2 ${categoryIdd}");
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
                                    style: AppTestStyle.headingBai(
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
                      padding: EdgeInsets.only(left: 20.0.sp, top: 30.sp),
                      child: BlocBuilder<CategoryWiseShowBloc1,
                          CategoryWiseShow1State>(
                        builder: (context, state) {
                          if (state is CategoryWiseShow1Loading) {
                            return const CircularProgressIndicator(); // Show loading indicator while data is being fetched
                          } else if (state is CategoryWiseShow1Loaded &&
                              state.shows.isNotEmpty) {
                            // Extracting show names and thumbnails from the loaded shows
                            List<String> showNames = state.shows
                                .map((show) => show.showName ?? 'No Show Name')
                                .toList();
                            print(
                                "inside blocBuilder Showwise 2  ${showNames}");
                            List<Widget> imageWidgets = state.shows.map((show) {
                              String imageUrl = show.thumbnail!.isNotEmpty
                                  ? show.thumbnail![0]
                                  : 'default_image_url';
                              print(
                                  "inside blocBuilder Showwise 1 ${imageUrl}");
                              return Image.network(imageUrl, fit: BoxFit.cover);
                            }).toList();

                            return HorizontalScrollableCard(
                              cardStatusColor: Colors.brown,
                              titlecard: showNames,
                              imageListCount: state.shows.length,
                              imageList: imageWidgets,
                              textColor: AppColors.white,
                            );
                          } else if (state is CategoryWiseShow1Error) {
                            return Text('Error: ${state.messages}');
                          } else {
                            return horizontalCardShimmerWidget(); // Or handle other states as needed
                          }
                        },
                      ),
                    )
                  ],
                ),
                // Stack(
                //   children: [
                //     SvgPicture.asset(IconAssets.appbackground),
                //     BlocBuilder<CategoryListBloc, CategoryListState>(
                //       builder: (context, state) {
                //         if (state is CategoryListLoaded &&
                //             state.categories.isNotEmpty) {
                //           return Center(
                //             child: Text(
                //               state.categories[2].categoryName ??
                //                   'Default Category Name',
                //               style: AppTestStyle.headingBai(
                //                   fontSize: 22.sp,
                //                   color: AppColors.black,
                //                   fontWeight: FontWeight.w800),
                //             ),
                //           );
                //         } else {
                //           return Center(child: buildTextShimmerEffect());
                //         }
                //       },
                //     ),
                //     Padding(
                //       padding: EdgeInsets.only(left: 20.0.sp, top: 30.sp),
                //       child: HorizontalScrollableCard(
                //           cardStatusColor: Colors.brown,
                //           titlecard: technologyimagepathtitle,
                //           imageListCount: technologiesImagepath.length,
                //           imageList: technologiesImagepath,
                //           textColor: AppColors.white),
                //     )
                //   ],
                // ),
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
                                    categoryIddd: categoryIddd));

                            print("inside bloclistner 2 ${categoryIddd}");
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
                                    style: AppTestStyle.headingBai(
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
                      padding: EdgeInsets.only(left: 20.0.sp, top: 30.sp),
                      child: BlocBuilder<CategoryWiseShowBloc2,
                          CategoryWiseShow2State>(
                        builder: (context, state) {
                          if (state is CategoryWiseShow2Loading) {
                            return const CircularProgressIndicator(); // Show loading indicator while data is being fetched
                          } else if (state is CategoryWiseShow2Loaded &&
                              state.shows.isNotEmpty) {
                            // Extracting show names and thumbnails from the loaded shows
                            List<String> showNames = state.shows
                                .map((show) => show.showName ?? 'No Show Name')
                                .toList();
                            print(
                                "inside blocBuilder Showwise 2  ${showNames}");
                            List<Widget> imageWidgets = state.shows.map((show) {
                              String imageUrl = show.thumbnail!.isNotEmpty
                                  ? show.thumbnail![0]
                                  : 'default_image_url';
                              print(
                                  "inside blocBuilder Showwise 1 ${imageUrl}");
                              return Image.network(imageUrl, fit: BoxFit.cover);
                            }).toList();

                            return HorizontalScrollableCard(
                              cardStatusColor: Colors.brown,
                              titlecard: showNames,
                              imageListCount: state.shows.length,
                              imageList: imageWidgets,
                              textColor: AppColors.white,
                            );
                          } else if (state is CategoryWiseShow2Error) {
                            return Text('Error: ${state.messages}');
                          } else {
                            return horizontalCardShimmerWidget(); // Or handle other states as needed
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
