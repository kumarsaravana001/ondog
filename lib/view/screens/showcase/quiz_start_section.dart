import 'package:flutter/material.dart';

import '../../../config/config_index.dart';
import '../../view_index.dart';

class QuizStartSection extends StatefulWidget {
  const QuizStartSection({super.key});

  @override
  State<QuizStartSection> createState() => _QuizStartSectionState();
}

class _QuizStartSectionState extends State<QuizStartSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: AppColors.black),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            !showQuizContent
                ? AppLocalisation.takethenextquiz
                : AppLocalisation.greatwork,
            style: AppTestStyle.headingBai(
                color: Colors.purple,
                fontSize: 21.sp,
                fontWeight: FontWeight.w800),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                !showQuizContent
                    ? AppLocalisation.earnpointstoclaimexistingrewards
                    : AppLocalisation.claimnextreward,
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
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.sp, vertical: 10.sp),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        showQuizContent = !showQuizContent;
                      });
                    },
                    child: Text(
                        showQuizContent
                            ? AppLocalisation.end
                            : AppLocalisation.start,
                        style: AppTestStyle.headingint(
                            color: AppColors.white, fontSize: 16.sp)),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
