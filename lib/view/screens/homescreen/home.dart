import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ondgo_flutter/config/config_index.dart';
import '../../../utilities/app_horizontal_scroll_card.dart';
import '../../../utilities/index.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                    clipper: StackHometopshape(),
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
                    right: 20.sp,
                    child: const HorizontalScrollableCard(),
                  ),
                  Positioned(
                    child: ClipPath(
                      clipper: StackHometopshape(),
                      child: Stack(
                        children: [
                          AppImages.dummyimage(
                              height: 70.h,
                              fit: BoxFit.cover,
                              width: double.infinity),
                          Positioned(
                            top: 10,
                            left: 30,
                            child: SvgPicture.asset(
                                IconAssets.ondgoTextlogowhite,
                                semanticsLabel: 'Ondgo Logo'),
                          ),
                          Positioned(
                            top: 0,
                            right: 30,
                            child: InkWell(
                              onTap: () {
                                context.go("/reels");
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
                                          text: 'Stream now'),
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
                                  Text(
                                    AppLocalisation.coffeewithcrypto,
                                    style: AppTestStyle.headingBai(
                                      fontSize: 24.sp,
                                      color: AppColors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    AppLocalisation.newepisodes,
                                    style: AppTestStyle.headingint(
                                      fontSize: 18.sp,
                                      color: AppColors.white,
                                      fontWeight: FontWeight.w600,
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
                              child: SvgPicture.asset(IconAssets.diamondstar,
                                  height: 14)),
                          Positioned(
                              bottom: 20,
                              right: 1,
                              left: 60,
                              child: SvgPicture.asset(IconAssets.diamondstar,
                                  height: 14)),
                          Positioned(
                              bottom: 20,
                              right: 60,
                              left: 1,
                              child: SvgPicture.asset(IconAssets.diamondstar,
                                  height: 14)),
                        ],
                      ),
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
                    child: Text(AppLocalisation.popularpicks,
                        style: AppTestStyle.headingBai(
                            fontSize: 22.sp,
                            color: AppColors.black,
                            fontWeight: FontWeight.w800)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.0.sp, top: 30.sp),
                    child: const HorizontalScrollableCard(),
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
    path_0.moveTo(size.width * -0.0016667, size.height * -0.0014286);
    path_0.lineTo(size.width * 1.0016667, size.height * -0.0028571);
    path_0.lineTo(size.width * 1.0008333, size.height * 0.8600000);
    path_0.lineTo(size.width * 0.5008333, size.height * 1.0057143);
    path_0.lineTo(size.width * -0.0008333, size.height * 0.8600000);
    path_0.lineTo(size.width * -0.0016667, size.height * -0.0014286);
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
    path_0.moveTo(size.width * -0.0016667, size.height * -0.0028571);
    path_0.lineTo(size.width, size.height * -0.0028571);
    path_0.lineTo(size.width * 1.0008333, size.height * 0.8585714);
    path_0.lineTo(size.width * 0.5000000, size.height * 1.0028571);
    path_0.lineTo(size.width * -0.0016667, size.height * 0.8585714);
    path_0.lineTo(size.width * -0.0016667, size.height * -0.0028571);
    path_0.close();
    return path_0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
