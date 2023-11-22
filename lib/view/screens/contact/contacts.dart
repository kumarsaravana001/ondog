import 'package:flutter/material.dart';

import '../../../config/config_index.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
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
                    child: Text(AppLocalisation.contact,
                        style: AppTestStyle.headingBai(fontSize: 28.sp))),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppLocalisation.checkourwebsit,
                        style: AppTestStyle.headingint(fontSize: 20.sp)),
                    Text(AppLocalisation.websitlink,
                        style: AppTestStyle.headingint(
                            fontSize: 20.sp, fontWeight: FontWeight.bold)),
                    SizedBox(height: 2.5.h),
                    Text(AppLocalisation.reachouttouson,
                        style: AppTestStyle.headingint(fontSize: 20.sp)),
                    Text(AppLocalisation.infoondgolive,
                        style: AppTestStyle.headingint(
                            fontSize: 20.sp, fontWeight: FontWeight.bold)),
                    SizedBox(height: 2.5.h),
                    Padding(
                      padding: EdgeInsets.only(bottom: 5.sp),
                      child: Text(AppLocalisation.socials,
                          style: AppTestStyle.headingint(
                              fontSize: 20.sp, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 5.sp),
                      child: Text(AppLocalisation.instagram,
                          style: AppTestStyle.headingint(
                              fontSize: 20.sp, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 5.sp),
                      child: Text(AppLocalisation.facebook,
                          style: AppTestStyle.headingint(
                              fontSize: 20.sp, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 5.sp),
                      child: Text(AppLocalisation.twitter,
                          style: AppTestStyle.headingint(
                              fontSize: 20.sp, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 5.sp),
                      child: Text(AppLocalisation.linkedin,
                          style: AppTestStyle.headingint(
                              fontSize: 20.sp, fontWeight: FontWeight.bold)),
                    ),
                  ],
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
      ),
    );
  }
}
