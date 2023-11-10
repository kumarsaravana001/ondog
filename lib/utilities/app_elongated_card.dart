import 'package:flutter/material.dart';

import '../config/app_textstyle.dart';
import '../config/config_index.dart';

class ElongatedCardWidget extends StatelessWidget {
  final String label;
  final String sublabel;
  final String date;
  final String amount;
  final VoidCallback onPressed;

  const ElongatedCardWidget({
    super.key,
    required this.label,
    required this.sublabel,
    required this.date,
    required this.amount,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey,
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  bottom: 15.sp, left: 15.sp, right: 15.sp, top: 20.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(sublabel,
                      style: AppTestStyle.headingint(
                          fontSize: 18.sp, color: AppColors.white)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(label,
                          style: AppTestStyle.headingBai(
                              fontWeight: FontWeight.bold,
                              fontSize: 24.sp,
                              color: AppColors.white)),
                      Text(AppLocalisation.online,
                          style: AppTestStyle.headingint(
                              fontSize: 18.sp, color: AppColors.white)),
                    ],
                  ),
                  SizedBox(height: 1.5.h),
                  Text(date,
                      style: AppTestStyle.headingint(
                          fontSize: 18.sp, color: AppColors.white)),
                  Padding(
                    padding: EdgeInsets.only(top: 8.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: onPressed,
                          child: Text(AppLocalisation.openLink,
                              style: AppTestStyle.headingint(
                                  underline: true,
                                  fontSize: 18.sp,
                                  color: AppColors.white)),
                        ),
                        Text(amount,
                            style: AppTestStyle.headingint(
                                fontSize: 18.sp, color: AppColors.white)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 1.h,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8)),
                color: Colors.purple,
              ),
            )
          ],
        ),
      ),
    );
  }
}
