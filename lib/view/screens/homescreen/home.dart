import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../config/config_index.dart';
import '../../../utilities/app_horizontal_scroll_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.black,
        body: SingleChildScrollView(
          child: Column(
            children: [
              ClipPath(
                clipper: TriangularClippertop(),
                child: Stack(
                  children: [
                    AppImages.dummyimage(
                        height: 45.h,
                        fit: BoxFit.cover,
                        width: double.infinity),
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
              SizedBox(
                height: 55.h,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 30,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalisation.coffeewithcrypto,
                            style: AppTestStyle.headingBai(
                              fontSize: 24.sp,
                              color: AppColors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            textAlign: TextAlign.start,
                            AppLocalisation.newepisodes,
                            style: AppTestStyle.headingint(
                              fontSize: 18.sp,
                              color: AppColors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 30.sp),
                                  child: SvgPicture.asset(
                                      IconAssets.diamondstar,
                                      height: 14),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.sp),
                                  child: SvgPicture.asset(
                                      IconAssets.diamondstar,
                                      height: 14),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 30.sp),
                                  child: SvgPicture.asset(
                                      IconAssets.diamondstar,
                                      height: 14),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                              padding:
                                  EdgeInsets.only(top: 20.sp, bottom: 20.sp),
                              child: Text(AppLocalisation.yourlist,
                                  style: AppTestStyle.headingBai(
                                      fontSize: 22.sp,
                                      color: AppColors.white,
                                      fontWeight: FontWeight.w700))),
                         
                          Container(
                            height: 200,
                            width: 400,
                            child: HorizontalScrollableCard(),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ClipPath(
                clipper: TriangularClipperbottom(),
                child: Stack(
                  children: [
                    Container(
                        height: 40.h,
                        color: AppColors.white,
                        child: SvgPicture.asset(IconAssets.appbackground)),
                    Padding(
                      padding: EdgeInsets.only(top: 10.sp),
                      child: Column(
                        children: [
                          Text(AppLocalisation.yourlist,
                              style: AppTestStyle.headingBai(
                                  fontSize: 22.sp,
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w700)),
                          const HorizontalScrollableCard(),
                        ],
                      ),
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

class TriangularClippertop extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * -0.0008333, 0);
    path_0.lineTo(size.width * 1.0016667, 0);
    path_0.lineTo(size.width * 1.0025000, size.height * 1.0042857);
    path_0.lineTo(size.width * 0.5008333, size.height * 0.7171429);
    path_0.lineTo(size.width * 0.0008333, size.height * 1.0014286);
    path_0.lineTo(size.width * -0.0008333, 0);
    path_0.close();
    return path_0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class TriangularClipperbottom extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * -0.0008333, size.height * 0.0014286);
    path_0.lineTo(size.width * 0.4991667, size.height * 0.3585714);
    path_0.lineTo(size.width * 1.0008333, size.height * -0.0014286);
    path_0.lineTo(size.width * 1.0008333, size.height * 1.0014286);
    path_0.lineTo(size.width * -0.0008333, size.height * 1.0028571);
    path_0.lineTo(size.width * -0.0008333, size.height * 0.0014286);
    path_0.close();
    return path_0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
