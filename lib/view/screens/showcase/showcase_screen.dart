import 'package:flutter/material.dart';
import 'package:ondgo_flutter/utilities/app_horizontal_scroll_card.dart';
import '../../../config/config_index.dart';
import '../../../utilities/app_scrollable_elongated_card.dart';

class ShowCaseScreen extends StatefulWidget {
  const ShowCaseScreen({super.key});

  @override
  State<ShowCaseScreen> createState() => _ShowCaseScreenState();
}

class _ShowCaseScreenState extends State<ShowCaseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
                child:
                    Center(child: SvgPicture.asset(IconAssets.appbackground))),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 20.sp, vertical: 10.sp),
                    child: Row(
                      children: [
                        SvgPicture.asset(IconAssets.ondgoTextlogo,
                            semanticsLabel: 'Ondgo Logo')
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 30.h,
                        decoration: const BoxDecoration(),
                        child: AppImages.dummyimage(),
                      ),
                      Positioned(
                        left: 10,
                        bottom: 20,
                        child: GestureDetector(
                          onTap: () {},
                          child: const Icon(
                            Icons.info_outline,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      Positioned(
                          right: 0,
                          top: 30,
                          child: Container(
                            decoration: const BoxDecoration(
                                color: AppColors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: Column(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: AppIconsWidget.favourites()),
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: AppIconsWidget.share()),
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: AppIconsWidget.message()),
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: AppIconsWidget.addtoplaylist()),
                              ],
                            ),
                          ))
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 18.sp, vertical: 15.sp),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: AppColors.black),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalisation.takethenextquiz,
                            style: AppTestStyle.headingBai(
                                color: Colors.purple,
                                fontSize: 21.sp,
                                fontWeight: FontWeight.w800),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppLocalisation
                                    .earnpointstoclaimexistingrewards,
                                style: AppTestStyle.headingBai(
                                    color: AppColors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: Colors.purple)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16.sp, vertical: 10.sp),
                                  child: Text(
                                    AppLocalisation.start,
                                    style: AppTestStyle.headingint(
                                      color: AppColors.white,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 18.sp),
                    child: Text(
                      AppLocalisation.episodes,
                      style: AppTestStyle.headingBai(fontSize: 26.sp),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15.sp),
                    child: ScrollableElongatedCardWidget(
                      label: AppLocalisation.coffeesession,
                      sublabel: AppLocalisation.registernowex,
                      sublabel1: AppLocalisation.interactwithcreators,
                      onPressed: () {},
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 18.sp),
                    child: Text(
                      AppLocalisation.events,
                      style: AppTestStyle.headingBai(
                        fontSize: 26.sp,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15.sp),
                    child: const HorizontalScrollableCard(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 18.sp),
                    child: Text(
                      AppLocalisation.relatedvideos,
                      style: AppTestStyle.headingBai(fontSize: 26.sp),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15.sp),
                    child: const HorizontalScrollableCard(),
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
