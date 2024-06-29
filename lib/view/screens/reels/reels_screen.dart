import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ondgo_flutter/bloc/homescreen_bloc/banner_bloc/homescreen_banner_state.dart';
import 'package:ondgo_flutter/bloc/showscreen_bloc/showDetails_bloc/show_details_bloc.dart';
import 'package:ondgo_flutter/utilities/app_bg.dart';
import 'package:ondgo_flutter/view/screens/homescreen/widgets/widget.dart';
import '../../../bloc/homescreen_bloc/banner_bloc/homescreen_banner_bloc.dart';
import '../../../bloc/homescreen_bloc/banner_bloc/homescreen_banner_event.dart';
import '../../../bloc/showscreen_bloc/showDetails_bloc/show_details_event.dart';
import '../../../bloc/showscreen_bloc/showId_cubit.dart';
import '../../../config/config_index.dart';

class ReelsScreen extends StatefulWidget {
  const ReelsScreen({super.key});

  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {
  int _currentCarouselIndex = 0;
  List<String> showNames = [];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeScreenBannerBloc>(
            create: (context) => HomeScreenBannerBloc()..add(FetchBanners())),
      ],
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    GoRouter.of(context).push('/fullScreenImage');
                  },
                  child: Stack(
                    children: [
                      ClipPath(
                        clipper: Hometopshape(),
                        child:
                            //  CarouselSlider(
                            //   items: [
                            //     AppImages.artbanner(),
                            //     AppImages.businessbanner(),
                            //     AppImages.healthcarebanner(),
                            //   ],
                            //   options: CarouselOptions(
                            //     // autoPlay: true,
                            //     autoPlayCurve: Curves.decelerate,
                            //     autoPlayInterval: const Duration(seconds: 5),
                            //     height: 68.h,
                            //     viewportFraction: 1,
                            //     initialPage: 0,
                            //     onPageChanged: (index, reason) {
                            //       setState(() {
                            //         _currentCarouselIndex = index;
                            //       });
                            //     },
                            //   ),
                            // ),
                            BlocBuilder<HomeScreenBannerBloc,
                                HomeScreenBannerState>(
                          builder: (context, state) {
                            if (state is HomeScreenBannerLoaded &&
                                state.banners.isNotEmpty) {
                              List<Widget> bannerWidgets = state.banners.expand(
                                (banner) {
                                  List<String> imageUrls =
                                      banner.thumbnail != null &&
                                              banner.thumbnail!.isNotEmpty
                                          ? banner.thumbnail!
                                          : [
                                              'assets/images/middleclass_banner.png'
                                            ];

                                  showNames.add(
                                      banner.categoryName ?? 'Default Banner');

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
                                          context.push("/fullScreenImage");
                                          BlocProvider.of<UserShowDetailBloc>(
                                                  context)
                                              .add(FetchUserShowDetail(
                                                  showId: int.parse(showId)));
                                        },
                                        child: Image.network(imageUrl,
                                            fit: BoxFit.fill),
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
                      ),
                      Positioned(
                        top: 8,
                        left: 30,
                        child: SvgPicture.asset(
                            IconAssets.ondgoTextlogoblackcovered,
                            height: 26.sp,
                            semanticsLabel: 'Ondgo Logo'),
                      ),
                      Positioned(
                          bottom: 40.sp,
                          left: 15.sp,
                          child:
                              SvgPicture.asset(IconAssets.reelsleftindicator)),
                      Positioned(
                          bottom: 15.sp,
                          left: MediaQuery.of(context).size.width / 2 - 20,
                          child: SvgPicture.asset(
                              IconAssets.reelscenterindicator)),
                      Positioned(
                          bottom: 40.sp,
                          right: 15.sp,
                          child:
                              SvgPicture.asset(IconAssets.reelsrightindicator)),
                      // Positioned(
                      //   top: 0,
                      //   right: 30,
                      //   child: InkWell(
                      //     onTap: () {},
                      //     child: SvgPicture.asset(IconAssets.badgecloseblack),
                      //   ),
                      // ),
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
                        child: SvgPicture.asset(IconAssets.badgecloseblack),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 4.sp, horizontal: 18.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppIconsWidget.favourites(),
                      // Text(
                      //   AppLocalisation.nutritiondaily,
                      //   style: AppTestStyle.headingBai(fontSize: 24.sp),
                      // ),
                      BlocBuilder<HomeScreenBannerBloc, HomeScreenBannerState>(
                        builder: (context, state) {
                          if (state is HomeScreenBannerLoaded &&
                              state.banners.isNotEmpty) {
                            showNames = state.banners
                                .map((banner) =>
                                    banner.categoryName ?? 'Default Banner')
                                .toList();

                            return Text(
                              _currentCarouselIndex < showNames.length
                                  ? showNames[_currentCarouselIndex]
                                  : 'Show loading',
                              style: GoogleFonts.baiJamjuree(
                                fontSize: 24.sp,
                                color: AppColors.black,
                                fontWeight: FontWeight.w800,
                              ),
                            );
                          } else if (state is HomeScreenBannerLoading) {
                            return buildbannerShimmerEffect();
                            //buildbannerShimmerEffect();
                          } else {
                            return Container();
                          }
                        },
                      ),
                      AppIconsWidget.share()
                    ],
                  ),
                ),
                Text(
                  AppLocalisation.newepisodes,
                  style: AppTextStyle.headingint(
                      fontSize: 16.sp, fontWeight: FontWeight.w500),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25.sp, bottom: 8.sp),
                  child: Text(
                    AppLocalisation.shareyourthoughts,
                    style: AppTextStyle.headingint(
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
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.sp, vertical: 15.sp),
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
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
                SizedBox(height: 12.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TriangularClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.0008333, size.height * -0.0028571);
    path_0.lineTo(size.width * 1.0025000, 0);
    path_0.lineTo(size.width, size.height * 0.7128571);
    path_0.lineTo(size.width * 0.4983333, size.height * 1.0028571);
    path_0.lineTo(0, size.height * 0.7142857);
    path_0.lineTo(size.width * 0.0008333, size.height * -0.0028571);
    path_0.close();
    return path_0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
