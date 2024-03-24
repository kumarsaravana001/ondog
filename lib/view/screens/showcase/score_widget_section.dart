import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/config_index.dart';

class ScoreWidget extends StatelessWidget {
  final int totalQuestions;
  final int correctAnswers;
  final VoidCallback onFinishPressed;
  const ScoreWidget(
      {super.key,
      required this.totalQuestions,
      required this.correctAnswers,
      required this.onFinishPressed});

  @override
  Widget build(BuildContext context) {
    double percentage = (correctAnswers / totalQuestions) * 100;

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
                      style:GoogleFonts.baiJamjuree(
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
                      style: GoogleFonts.baiJamjuree(
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
                          onTap: onFinishPressed,
                          child: Text(AppLocalisation.finish,
                              style: AppTextStyle.headingint(
                                  color: AppColors.white, fontSize: 16.sp)),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Text(
                  'Total Questions: $totalQuestions',
                  style:
                      const TextStyle(fontSize: 18.0, color: AppColors.white),
                ),
                const SizedBox(height: 10.0),
                Text(
                  'Correct Answers: $correctAnswers',
                  style:
                      const TextStyle(fontSize: 18.0, color: AppColors.white),
                ),
                const SizedBox(height: 10.0),
                Text(
                  'Percentage: ${percentage.toStringAsFixed(2)}%',
                  style:
                      const TextStyle(fontSize: 18.0, color: AppColors.white),
                ),
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
                  style: AppTextStyle.headingint(
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
