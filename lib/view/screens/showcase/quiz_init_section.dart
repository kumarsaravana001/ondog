import 'package:flutter/material.dart';
import '../../../config/config_index.dart';

class QuizInitWIdget extends StatefulWidget {
    final VoidCallback onStartQuiz; // Define the callback here

  const QuizInitWIdget({super.key, required this.onStartQuiz});

  @override
  State<QuizInitWIdget> createState() => _QuizInitWIdgetState();
}

class _QuizInitWIdgetState extends State<QuizInitWIdget> {
  bool showQuizContent = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.sp, vertical: 15.sp),
      child: Container(
        padding: EdgeInsets.all(15.sp),
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
                    padding: EdgeInsets.symmetric(
                        horizontal: 16.sp, vertical: 10.sp),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          showQuizContent = !showQuizContent;
                        });
                        widget.onStartQuiz();
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
      ),
    );
  }
}
