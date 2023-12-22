import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ondgo_flutter/config/config_index.dart';
import '../../../utilities/app_horizontal_scroll_card.dart';
import '../../../utilities/index.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentCarouselIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: 40.sp),
          child: FloatingActionButton(
            onPressed: () {
              context.push("/search");
            },
            backgroundColor: AppColors.black,
            child: const Icon(Icons.search, color: AppColors.white),
          ),
        ),
        body: SingleChildScrollView(
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
                      right: 48.sp,
                      child: Text(AppLocalisation.yourlist,
                          style: AppTestStyle.headingBai(
                              fontSize: 22.sp,
                              color: AppColors.white,
                              fontWeight: FontWeight.w700))),
                  Positioned(
                    bottom: 50.sp,
                    left: 20.sp,
                    right: 8.sp,
                    child: HorizontalScrollableCard(
                        cardbackgroundcolor: AppColors.white),
                  ),
                  Positioned(
                    child: ClipPath(
                      clipper: StackHometopshape(),
                      child: Stack(
                        children: [
                          CarouselSlider(
                            items: [
                              AppImages.educationcard(),
                              AppImages.artscard(),
                              AppImages.wellnesscard(),
                            ],
                            options: CarouselOptions(
                              autoPlay: false,
                              autoPlayCurve: Curves.decelerate,
                              autoPlayInterval: const Duration(seconds: 5),
                              height: 71.h,
                              viewportFraction: 1,
                              initialPage: 0,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _currentCarouselIndex = index;
                                });
                              },
                            ),
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
                                context.push("/profile");
                              },
                              child:
                                  SvgPicture.asset(IconAssets.badgecloseblack),
                            ),
                          ),
                          Positioned(
                            top: 75.sp,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.sp),
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
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white60),
                                    child: Padding(
                                      padding: EdgeInsets.all(10.sp),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppLocalisation.coffeewithcrypto,
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
                                IconAssets.diamondstar,
                                height: 14,
                                // ignore: deprecated_member_use
                                color: _currentCarouselIndex == 0
                                    ? Colors.white
                                    : Colors.grey,
                              )),
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
                              )),
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
                    child: Text(AppLocalisation.popularpicks,
                        style: AppTestStyle.headingBai(
                            fontSize: 22.sp,
                            color: AppColors.black,
                            fontWeight: FontWeight.w800)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.0.sp, top: 30.sp),
                    child: HorizontalScrollableCard(
                      textColor: AppColors.white,
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
                    child: Text(AppLocalisation.events,
                        style: AppTestStyle.headingBai(
                            fontSize: 22.sp,
                            color: AppColors.black,
                            fontWeight: FontWeight.w800)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.0.sp, top: 30.sp),
                    child: HorizontalScrollableCard(
                      textColor: AppColors.white,
                    ),
                  ),
                ],
              ),
              Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 45.sp),
                    child: SvgPicture.asset(IconAssets.appbackground),
                  ),
                  Center(
                    child: Text(AppLocalisation.arts,
                        style: AppTestStyle.headingBai(
                            fontSize: 22.sp,
                            color: AppColors.black,
                            fontWeight: FontWeight.w800)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.0.sp, top: 30.sp),
                    child: HorizontalScrollableCard(
                      textColor: AppColors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Hometopshape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * -0.0008333, size.height * 0.0014286);
    path_0.lineTo(size.width * 1.0008333, size.height * -0.0028571);
    path_0.lineTo(size.width * 1.0008333, size.height * 0.8571429);
    path_0.lineTo(size.width * 0.5000000, size.height);
    path_0.lineTo(size.width * -0.0008333, size.height * 0.8571429);
    path_0.lineTo(size.width * -0.0008333, size.height * 0.0014286);
    path_0.close();
    return path_0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class StackHometopshape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.0008333, size.height * 0.0014286);
    path_0.lineTo(size.width * 0.9991667, size.height * -0.0014286);
    path_0.lineTo(size.width * 0.9991667, size.height * 0.8585714);
    path_0.lineTo(size.width * 0.5008333, size.height * 1.0014286);
    path_0.lineTo(size.width * -0.0008333, size.height * 0.8600000);
    path_0.lineTo(size.width * 0.0008333, size.height * 0.0014286);
    path_0.close();
    return path_0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

// class StackHometopshape extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Path path_0 = Path();
//     path_0.moveTo(size.width * -0.0041667, 0);
//     path_0.lineTo(size.width * 1.0016667, size.height * -0.0042857);
//     path_0.lineTo(size.width * 1.0016667, size.height * 0.7157143);
//     path_0.lineTo(size.width * 0.5008333, size.height * 1.0042857);
//     path_0.lineTo(size.width * -0.0025000, size.height * 0.7157143);
//     path_0.lineTo(size.width * -0.0041667, 0);
//     path_0.close();
//     return path_0;
//   }

//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
//     return false;
//   }
// }
