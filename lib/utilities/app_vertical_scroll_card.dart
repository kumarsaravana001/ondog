import 'package:flutter/material.dart';

import '../config/config_index.dart';

class AppVerticalScrollCard extends StatelessWidget {
  const AppVerticalScrollCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.black,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 14.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AppLocalisation.finance,
                        style: AppTestStyle.headingint(
                            fontSize: 16.sp,
                            color: AppColors.white,
                            fontWeight: FontWeight.bold)),
                    Text(AppLocalisation.ddmm,
                        style: AppTestStyle.headingint(
                            fontSize: 16.sp,
                            color: AppColors.white,
                            fontWeight: FontWeight.bold))
                  ],
                ),
                Text(AppLocalisation.commingsoon,
                    style: AppTestStyle.headingint(
                        fontSize: 15.sp,
                        color: AppColors.white,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Expanded(child: AppImages.dummyimage(fit: BoxFit.cover)),
          ClipRRect(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15)),
            child: Container(
              height: 10,
              color: Colors.purple,
            ),
          )
        ],
      ),
    );
  }
}
