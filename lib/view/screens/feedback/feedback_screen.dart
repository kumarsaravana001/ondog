import 'package:flutter/material.dart';

import '../../../config/config_index.dart';
import '../../../utilities/index.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
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
            Column(
              children: [
                SvgPicture.asset(
                    width: MediaQuery.of(context).size.width,
                    IconAssets.profilescreenbgblack),
                Align(
                    alignment: Alignment.center,
                    child: Text(AppLocalisation.feedback,
                        style: AppTestStyle.headingBai(fontSize: 28.sp))),
                Padding(
                  padding: EdgeInsets.fromLTRB(15.sp, 30.sp, 15.sp, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(controller: nameController),
                      SizedBox(height: 1.5.h),
                      CustomTextField(controller: emailController),
                      SizedBox(height: 1.5.h),
                      Container(
                        height: 70.sp,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const TextField(
                          decoration: InputDecoration(
                            hintText: 'Comments',
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 15),
                          ),
                          maxLines: null,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: CustomElevatedButton(
                          fontsize: 18.sp,
                          labelcolor: AppColors.black,
                          backgroundcolor: AppColors.white,
                          bordercolor: AppColors.black,
                          text: 'Send',
                          onPressed: () {},
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 0,
              right: 30,
              child: Row(
                children: [SvgPicture.asset(IconAssets.badgeclose)],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
