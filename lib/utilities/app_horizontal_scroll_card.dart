// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

import '../config/config_index.dart';

class HorizontalScrollableCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      //  margin: const EdgeInsets.all(16.0),
      //  margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
      ),
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 6,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            // padding: const EdgeInsets.all(8),
            width: 150,
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: AppColors.black,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.sp, horizontal: 14.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppLocalisation.finance,
                              style: AppTestStyle.headingint(
                                  fontSize: 16.sp,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold)),
                          Text(AppLocalisation.ratingcount,
                              style: AppTestStyle.headingint(
                                  fontSize: 15.sp,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const Icon(Icons.diamond, color: AppColors.white),
                    ],
                  ),
                ),
                Expanded(
                    child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                        child: AppImages.dummyimage(fit: BoxFit.cover))),
              ],
            ),
          );
        },
      ),
    );
  }
}
