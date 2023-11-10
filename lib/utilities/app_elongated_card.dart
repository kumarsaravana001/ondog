import 'package:flutter/material.dart';
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
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.purple,
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              child: AppImages.dummyimage(
                  height: 18.h, fit: BoxFit.cover, width: double.infinity),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
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
                      // Container(
                      //   height: 1.h,
                      //   decoration: const BoxDecoration(
                      //     borderRadius: BorderRadius.only(
                      //         bottomLeft: Radius.circular(8),
                      //         bottomRight: Radius.circular(8)),
                      //     color: Colors.purple,
                      //   ),
                      // )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
