import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../config/config_index.dart';
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
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  AppImages.dummyimage(
                      height: 45.h, fit: BoxFit.cover, width: double.infinity),
                  Container(height: 62.h),
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
                        child:  HorizontalScrollableCard(),
                      ),
                    ],
                  ),
                ],
              ),
              Positioned(
                child: Padding(
                  padding: EdgeInsets.only(top: 60.sp),
                  child: Stack(
                    children: [
                      SvgPicture.asset(
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                          IconAssets.homescreenblackbg),
                      Positioned(
                          top: 40,
                          left: 25,
                          child: CustomElevatedButton(
                              backgroundcolor: AppColors.black,
                              bordercolor: AppColors.white,
                              fontsize: 13,
                              labelcolor: AppColors.white,
                              onPressed: () {},
                              text: 'Stream now')),
                      Positioned(
                          top: 60,
                          right: 45,
                          child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.black,
                                border: Border.all(color: AppColors.white),
                              ),
                              child: const Icon(Icons.add,
                                  color: AppColors.white))),
                      Positioned(
                        top: 100,
                        left: 30,
                        child: Text(
                          AppLocalisation.coffeewithcrypto,
                          style: AppTestStyle.headingBai(
                            fontSize: 24.sp,
                            color: AppColors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 150,
                        left: 30,
                        child: Text(
                          AppLocalisation.newepisodes,
                          style: AppTestStyle.headingint(
                            fontSize: 18.sp,
                            color: AppColors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Positioned(
                          top: 220,
                          left: 0,
                          right: 0,
                          child: Center(
                              child: Padding(
                                  padding: EdgeInsets.only(right: 40.sp),
                                  child: SvgPicture.asset(
                                      IconAssets.diamondstar,
                                      height: 14)))),
                      Positioned(
                          top: 215,
                          left: 0,
                          right: 0,
                          child: Center(
                              child: Padding(
                                  padding: EdgeInsets.only(top: 20.sp),
                                  child: SvgPicture.asset(
                                    IconAssets.diamondstar,
                                    height: 14,
                                  )))),
                      Positioned(
                          top: 220,
                          left: 0,
                          right: 0,
                          child: Center(
                              child: Padding(
                                  padding: EdgeInsets.only(left: 40.sp),
                                  child: SvgPicture.asset(
                                    IconAssets.diamondstar,
                                    height: 14,
                                  )))),
                      Positioned(
                          top: MediaQuery.of(context).size.height * 0.3,
                          left: 0,
                          right: 0,
                          child: Center(
                              child: Padding(
                                  padding: EdgeInsets.only(top: 20.sp),
                                  child: Text(AppLocalisation.yourlist,
                                      style: AppTestStyle.headingBai(
                                          fontSize: 22.sp,
                                          color: AppColors.white,
                                          fontWeight: FontWeight.w700))))),
                       Positioned(
                          bottom: 100,
                          left: 30,
                          right: 30,
                          child: HorizontalScrollableCard())
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 10,
                left: 30,
                child: SvgPicture.asset(IconAssets.ondgoTextlogowhite,
                    semanticsLabel: 'Ondgo Logo'),
              ),
              Positioned(
                top: 0,
                right: 30,
                child: InkWell(
                  onTap: () {
                    context.go("/reels");
                  },
                  child: SvgPicture.asset(IconAssets.badgeclose),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
