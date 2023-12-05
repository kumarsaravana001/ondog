import 'package:flutter/material.dart';

import '../../../config/config_index.dart';

class ScoreWidget extends StatefulWidget {
  const ScoreWidget({super.key});

  @override
  State<ScoreWidget> createState() => _ScoreWidgetState();
}

class _ScoreWidgetState extends State<ScoreWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          child: Container(
            height: 30.h,
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: AppColors.black),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalisation.greatwork,
                      style: AppTestStyle.headingBai(
                          color: Colors.purple,
                          fontSize: 21.sp,
                          fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalisation.claimnextreward,
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
                        child: InkWell(
                          onTap: () {},
                          child: Text(AppLocalisation.finish,
                              style: AppTestStyle.headingint(
                                  color: AppColors.white, fontSize: 16.sp)),
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
          padding: EdgeInsets.symmetric(horizontal: 5.sp, vertical: 12.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppLocalisation.checkyourprogress,
                  style: AppTestStyle.headingint(
                      color: AppColors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600)),
              const Icon(Icons.arrow_forward, size: 30)
            ],
          ),
        )
      ],
    );
  }
}