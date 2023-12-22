import 'package:flutter/material.dart';
import '../../../config/config_index.dart';
import '../../../utilities/app_horizontal_scroll_card.dart';
import '../../../utilities/index.dart';

class SearchandLibraryScreen extends StatefulWidget {
  const SearchandLibraryScreen({super.key});

  @override
  State<SearchandLibraryScreen> createState() => _SearchandLibraryScreenState();
}

class _SearchandLibraryScreenState extends State<SearchandLibraryScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              ClipPath(
                clipper: Hometopshape(),
                child: Stack(
                  children: [
                    Container(
                      height: 30.h,
                      color: AppColors.black,
                    ),
                    Positioned(
                      top: 0,
                      right: 30,
                      child: Row(
                        children: [SvgPicture.asset(IconAssets.badgeclose)],
                      ),
                    ),
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
                          top: 38.sp, left: 20.sp, right: 20.sp),
                      child: CustomTextField(
                        controller: searchController,
                        hintText: "Search",
                        borderColor: AppColors.white,
                        textColor: AppColors.white,
                        suffixIcon: Icons.search,
                        onSuffixIconPressed: () {},
                      ),
                    )
                  ],
                ),
              ),
              Stack(
                children: [
                  SvgPicture.asset(
                    IconAssets.spotlightbgframe1,
                    fit: BoxFit.cover,
                    height: 35.h,
                  ),
                  Positioned(
                    left: 20.sp,
                    right: 05.sp,
                    child: Column(
                      children: [
                        Text(
                          AppLocalisation.spotlight,
                          style: AppTestStyle.headingBai(fontSize: 26.sp),
                        ),
                        HorizontalScrollableCard(
                            textColor: AppColors.white,
                            subtitle: AppLocalisation.ratingcount),
                      ],
                    ),
                  ),
                ],
              ),
              // SizedBox(height: 7.h),
              Stack(
                children: [
                  SvgPicture.asset(IconAssets.spotlightbgframe2,
                      height: 35.h, fit: BoxFit.cover),
                  Positioned(
                    left: 20.sp,
                    right: 05.sp,
                    child: Column(
                      children: [
                        Text(
                          AppLocalisation.artanddesign,
                          style: AppTestStyle.headingBai(fontSize: 26.sp),
                        ),
                        HorizontalScrollableCard(
                            textColor: AppColors.white,
                            subtitle: AppLocalisation.ratingcount),
                      ],
                    ),
                  ),
                ],
              ),
              //  SizedBox(height: 7.h),
              Stack(
                children: [
                  SvgPicture.asset(
                    IconAssets.spotlightbgframe3,
                    height: 35.h,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    left: 20.sp,
                    right: 05.sp,
                    child: Column(
                      children: [
                        Text(
                          AppLocalisation.wellness,
                          style: AppTestStyle.headingBai(fontSize: 26.sp),
                        ),
                        HorizontalScrollableCard(
                            textColor: AppColors.white,
                            subtitle: AppLocalisation.ratingcount),
                      ],
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
    path_0.moveTo(size.width * -0.0025000, size.height * -0.0028571);
    path_0.lineTo(size.width * 1.0016667, size.height * -0.0028571);
    path_0.lineTo(size.width * 1.0016667, size.height * 0.7142857);
    path_0.lineTo(size.width * 0.5000000, size.height * 1.0028571);
    path_0.lineTo(size.width * -0.0016667, size.height * 0.7100000);
    path_0.lineTo(size.width * -0.0025000, size.height * -0.0028571);
    path_0.close();
    return path_0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
