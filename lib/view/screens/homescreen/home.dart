import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:ondgo_flutter/bloc/login_bloc/login_bloc.dart';
import 'package:ondgo_flutter/config/config_index.dart';
import 'package:ondgo_flutter/models/homescreen_model/banner_model.dart';
import 'package:ondgo_flutter/models/homescreen_model/category_list_model.dart';
import 'package:ondgo_flutter/models/homescreen_model/popular_picks_model.dart';
import 'package:ondgo_flutter/utilities/app_banner_list.dart';
import 'package:ondgo_flutter/utilities/app_bg.dart';
import '../../../bloc/homescreen_bloc/category_wise_show_bloc/category_wise_show_bloc.dart';
import '../../../bloc/homescreen_bloc/category_wise_show_bloc/category_wise_show_state.dart';
import '../../../utilities/app_horizontal_scroll_card.dart';
import '../../../utilities/index.dart';
import 'package:carousel_slider/carousel_slider.dart';

//trends
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> popularPicks = [];
  List<String> showNames = [];
  List<String> categoryList = [];

  int _currentCarouselIndex = 0;

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
      return Image.network(url);
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
    List<Widget> bannerWidgets = banners.map((banner) {
      String imageUrl = banner.thumbnail != null && banner.thumbnail!.isNotEmpty
          ? banner.thumbnail!.last
          : 'assets/images/coffee_with_crypto.png';

      showNames.add(banner.categoryName ?? 'Default Banner');

      return Image.network(imageUrl, fit: BoxFit.cover);
    }).toList();
    return CarouselSlider(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final loginBloc = BlocProvider.of<LoginBloc>(context);
    final homeScreenBannerBloc = BlocProvider.of<HomeScreenBannerBloc>(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeScreenBannerBloc>(
            create: (context) =>
                HomeScreenBannerBloc(loginBloc)..add(FetchBanners())),
        BlocProvider<PopularPicksBloc>(
            create: (context) =>
                PopularPicksBloc(loginBloc)..add(FetchPopularPicks())),
        BlocProvider<CategoryListBloc>(
          create: (context) =>
              CategoryListBloc(loginBloc)..add(FetchCategoryList()),
        ),
        BlocProvider<CategoryWiseShowBloc>(
          create: (context) =>
              CategoryWiseShowBloc(loginBloc)..add(FetchCategoryWiseShows()),
        ),
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
                        color: AppColors.black,
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
                                  print(
                                      "Current index: $_currentCarouselIndex");
                                  print("Show names: $showNames");

                                  return buildBannerCarousel(state.banners);
                                } else if (state is HomeScreenBannerLoading) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else {
                                  return const Center(
                                      child: Text('Error loading banners'));
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
                                onTap: () {
                                  // context.push("/home");
                                },
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
                      child: SvgPicture.asset(IconAssets.appbackground),
                    ),
                    Center(
                      child: Text(
                        AppLocalisation.popularpicks,
                        style: AppTestStyle.headingBai(
                            fontSize: 22.sp,
                            color: AppColors.black,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.0.sp, top: 30.sp),
                      child: BlocBuilder<PopularPicksBloc, PopularPicksState>(
                        builder: (context, state) {
                          if (state is PopularPicksLoaded) {
                            return popularPicksWidget(state.popularPicks);
                          } else if (state is PopularPicksLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else {
                            return const Center(
                                child: Text('Error loading banners'));
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
                      child: BlocBuilder<CategoryListBloc, CategoryListState>(
                        builder: (context, state) {
                          if (state is CategoryListLoaded &&
                              state.categories.isNotEmpty) {
                            return Text(
                              state.categories[0].categoryName ??
                                  'Default Category Name', // Access the first item's categoryName
                              style: AppTestStyle.headingBai(
                                  fontSize: 22.sp,
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w800),
                            );
                          } else {
                            return const Text('Loading');
                          }
                        },
                      ),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.only(left: 20.0.sp, top: 30.sp),
                    //   child: HorizontalScrollableCard(
                    //     cardStatusColor: Colors.blue,
                    //     titlecard: healthCareimagepathtitle,
                    //     imageListCount: healthcareImagepath.length,
                    //     imageList: healthcareImagepath,
                    //     textColor: AppColors.white,
                    //   ),
                    // ),

                    BlocBuilder<CategoryWiseShowBloc, CategoryWiseShowState>(
                      builder: (context, state) {
                        if (state is CategoryWiseShowLoading) {
                          return CircularProgressIndicator();
                        } else if (state is CategoryWiseShowLoaded) {
                          List<String> showNames = state.shows
                              .map((show) => show.showName ?? 'No Show Name')
                              .toList();
                          List<Widget> imageWidgets = state.shows.map((show) {
                            String imageUrl = show.thumbnail!.isNotEmpty
                                ? show.thumbnail!.first
                                : 'default_image_url';
                            return Image.network(imageUrl, fit: BoxFit.cover);
                          }).toList();
                          return Padding(
                            padding: EdgeInsets.only(left: 20.0.sp, top: 30.sp),
                            child: HorizontalScrollableCard(
                              cardStatusColor: Colors.blue,
                              titlecard: showNames,
                              imageListCount: state.shows.length,
                              imageList: imageWidgets,
                              textColor: AppColors.white,
                            ),
                          );
                          // ListView.builder(
                          //   shrinkWrap: true,
                          //   itemCount: state.shows.length,
                          //   itemBuilder: (context, index) {
                          //     final show = state.shows[index];
                          //     return ListTile(
                          //       title: Text(show.categoryName!),
                          //       subtitle: Text(show.categoryName!),
                          //     );
                          //   },
                          // );
                        } else if (state is CategoryWiseShowError) {
                          return Center(child: Text('Error: ${state.message}'));
                        } else {
                          return Center(
                              child: Text('Please select a category.'));
                        }
                      },
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
                      child: BlocBuilder<CategoryListBloc, CategoryListState>(
                        builder: (context, state) {
                          if (state is CategoryListLoaded &&
                              state.categories.isNotEmpty) {
                            return Text(
                              state.categories[1].categoryName ??
                                  'Default Category Name', // Access the first item's categoryName
                              style: AppTestStyle.headingBai(
                                  fontSize: 22.sp,
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w800),
                            );
                          } else {
                            return const Text('Loading');
                          }
                        },
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 20.0.sp, top: 30.sp),
                        child: HorizontalScrollableCard(
                            cardStatusColor: Colors.brown,
                            titlecard: legalimagepathtitle,
                            imageListCount: legalImagepath.length,
                            imageList: legalImagepath,
                            textColor: AppColors.white))
                  ],
                ),
                Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 45.sp),
                      child: SvgPicture.asset(IconAssets.appbackground),
                    ),
                    Center(
                      child: Text(AppLocalisation.technology,
                          style: AppTestStyle.headingBai(
                              fontSize: 22.sp,
                              color: AppColors.black,
                              fontWeight: FontWeight.w800)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.0.sp, top: 30.sp),
                      child: HorizontalScrollableCard(
                        cardStatusColor: Colors.blue[300]!,
                        titlecard: technologyimagepathtitle,
                        imageListCount: technologiesImagepath.length,
                        imageList: technologiesImagepath,
                        textColor: AppColors.white,
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

  // Widget buildCategoryList(List<CategoryListData> categories) {
  //   return ListView.builder(
  //     shrinkWrap: true, // to make it work inside a Column
  //     physics: const NeverScrollableScrollPhysics(), // to prevent inner scroll
  //     itemCount: categories.length,
  //     itemBuilder: (context, index) {
  //       var category = categories[index];
  //       return ListTile(
  //         title: Text(category.categoryName ?? 'No Name'),
  //       );
  //     },
  //   );
  // }
}
