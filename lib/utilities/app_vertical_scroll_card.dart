import 'package:flutter/material.dart';

import '../config/app_textstyle.dart';
import '../config/config_index.dart';

class AppVerticalScrollCard extends StatelessWidget {
  const AppVerticalScrollCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //width: 42.w,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
                color: AppColors.black,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AppLocalisation.finance,
                        style: AppTestStyle.headingint(
                            color: AppColors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold)),
                    Text(AppLocalisation.ddmm,
                        style: AppTestStyle.headingint(
                            color: AppColors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold))
                  ],
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(AppLocalisation.registernowex,
                      style: AppTestStyle.headingint(
                          color: AppColors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.red[200],
            ),
          ),
          Container(
            height: 15.sp,
            decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                )),
          )
        ],
      ),
    );
  }
}
