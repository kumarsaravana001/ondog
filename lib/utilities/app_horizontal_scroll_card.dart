import 'package:flutter/material.dart';
import 'package:ondgo_flutter/config/app_textstyle.dart';

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
              padding: const EdgeInsets.all(8),
              width: 150,
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: AppColors.black,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                children: [
                  Row(
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
                      )
                    ],
                  ),
                  const Expanded(
                    child: Icon(
                      Icons.star,
                      color: AppColors.white,
                      size: 80,
                    ),
                  ),
                ],
              )
              // Center(
              //   child: Text(
              //     'Card $index',
              //     style: const TextStyle(color: Colors.white, fontSize: 20),
              //   ),
              // ),
              );
        },
      ),
    );
  }
}
