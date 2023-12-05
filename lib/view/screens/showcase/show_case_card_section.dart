import 'package:flutter/material.dart';

import '../../../config/config_index.dart';
import '../../../utilities/app_horizontal_scroll_card.dart';
import '../../../utilities/app_scrollable_elongated_card.dart';

class ShowCaseCardSections extends StatelessWidget {
  const ShowCaseCardSections({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.only(left: 18.sp),
              child: Text(AppLocalisation.episodes,
                  style: AppTestStyle.headingBai(
                      fontSize: 26.sp))),
          Padding(
              padding: EdgeInsets.only(left: 15.sp),
              child: HorizontalScrollableCard(
                textColor: AppColors.white,
                subtitle: AppLocalisation.episode1,
              )),
          Padding(
              padding: EdgeInsets.only(left: 18.sp),
              child: Text(AppLocalisation.events,
                  style: AppTestStyle.headingBai(
                      fontSize: 26.sp))),
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
            padding: EdgeInsets.only(left: 15.sp, top: 20.sp),
            child: Text(
              AppLocalisation.shareyourthoughts,
              style: AppTestStyle.headingint(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.fromLTRB(20.sp, 15.sp, 0, 10.sp),
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
            padding:
                EdgeInsets.fromLTRB(20.sp, 15.sp, 0, 10.sp),
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
                          text: AppLocalisation
                              .thanksforsharring,
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
            padding: EdgeInsets.symmetric(
                horizontal: 20.sp, vertical: 15.sp),
            child: Container(
              height: 6.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: AppColors.black),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, // Adjust alignment
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0),
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
                      border:
                          Border.all(color: AppColors.black),
                      color:
                          AppColors.black, // Background color
                    ),
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.sp),
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
        ],
      );
  }
}