// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../config/config_index.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              bottom: -125,
              left: -10,
              right: 30,
              child: SvgPicture.asset(IconAssets.bottombgdiamond),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      SvgPicture.asset(
                          width: MediaQuery.of(context).size.width,
                          IconAssets.profilescreenbgblack),
                      Positioned(
                        top: 0,
                        right: 30,
                        child: Row(
                          children: [SvgPicture.asset(IconAssets.badgeopen)],
                        ),
                      ),
                      Positioned(
                        top: 10,
                        left: 20,
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: const Icon(Icons.arrow_back_outlined,
                                  color: AppColors.white, size: 30),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      AppLocalisation.help,
                      style: AppTestStyle.headingBai(fontSize: 26.sp),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.sp),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: AppImages.helpbanner(),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(top: 20.sp, bottom: 8.sp),
                      child: Text(
                        AppLocalisation.faq,
                        style: AppTestStyle.headingBai(fontSize: 26.sp),
                      ),
                    ),
                  ),
                  FAQSection(
                    questions: AppLocalisation.faqQues1,
                    answers: AppLocalisation.faqAns1,
                  ),
                  FAQSection(
                    questions: AppLocalisation.faqQues2,
                    answers: AppLocalisation.faqAns2,
                  ),
                  FAQSection(
                    questions: AppLocalisation.faqQues3,
                    answers: AppLocalisation.faqAns3,
                  ),
                  FAQSection(
                    questions: AppLocalisation.faqQues4,
                    answers: AppLocalisation.faqAns4,
                  ),
                  FAQSection(
                    questions: AppLocalisation.faqQues5,
                    answers: AppLocalisation.faqAns5,
                  ),
                  SizedBox(height: 5.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class FAQSection extends StatelessWidget {
  String questions;
  String answers;
  FAQSection({
    Key? key,
    required this.questions,
    required this.answers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            questions,
            style: AppTestStyle.headingBai(fontSize: 18.sp),
          ),
          SizedBox(height: 1.5.h),
          Text(
            answers,
            style: AppTestStyle.headingBai(
                fontSize: 18.sp,
                fontWeight: FontWeight.normal,
                color: Colors.grey[600]!),
          ),
          SizedBox(height: 1.5.h),
        ],
      ),
    );
  }
}
