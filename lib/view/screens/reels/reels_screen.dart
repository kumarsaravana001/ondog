import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../config/config_index.dart';

class ReelsScreen extends StatefulWidget {
  const ReelsScreen({super.key});

  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  const imageAsset = 'assets/images/dummy.png';
                  GoRouter.of(context).go('/fullScreenImage/$imageAsset');
                },
                child: Stack(
                  children: [
                    ClipPath(
                        clipper: TriangularClipper(),
                        child: AppImages.dummyimage(
                            height: 60.h,
                            fit: BoxFit.cover,
                            width: double.infinity)),
                    Positioned(
                        top: 10,
                        left: 30,
                        child: SvgPicture.asset(IconAssets.ondgoTextlogowhite,
                            semanticsLabel: 'Ondgo Logo')),
                    Positioned(
                        bottom: 130,
                        left: 10,
                        child: SvgPicture.asset(IconAssets.reelsleftindicator)),
                    Positioned(
                        bottom: 10,
                        left: MediaQuery.of(context).size.width / 2 - 20,
                        child:
                            SvgPicture.asset(IconAssets.reelscenterindicator)),
                    Positioned(
                        bottom: 130,
                        right: 10,
                        child:
                            SvgPicture.asset(IconAssets.reelsrightindicator)),
                    Positioned(
                      top: 0,
                      right: 30,
                      child: SvgPicture.asset(IconAssets.badgeclose),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 10.sp, horizontal: 16.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppIconsWidget.favourites(),
                    Text(
                      AppLocalisation.nutritiondaily,
                      style: AppTestStyle.headingBai(fontSize: 24.sp),
                    ),
                    AppIconsWidget.share()
                  ],
                ),
              ),
              Text(
                AppLocalisation.newepisodes,
                style: AppTestStyle.headingint(
                    fontSize: 18.sp, fontWeight: FontWeight.w500),
              ),
              Padding(
                padding: EdgeInsets.only(top: 25.sp, bottom: 15.sp),
                child: Text(
                  AppLocalisation.shareyourthoughts,
                  style: AppTestStyle.headingint(
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
                              style: AppTestStyle.headingint(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.white),
                            ),
                            TextSpan(
                              text: AppLocalisation.sotrue,
                              style: AppTestStyle.headingint(
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
                              style: AppTestStyle.headingint(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.white),
                            ),
                            TextSpan(
                              text: AppLocalisation.thanksforsharring,
                              style: AppTestStyle.headingint(
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
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
