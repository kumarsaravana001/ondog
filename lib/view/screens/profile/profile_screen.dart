import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ondgo_flutter/config/config_index.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SvgPicture.asset(
                  width: MediaQuery.of(context).size.width,
                  IconAssets.profilebg,
                ),
                Positioned(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 35.sp),
                      child: Column(
                        children: [
                          Container(
                            width: 120,
                            height: 150,
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(12)),
                                child: AppImages.dummyimage(fit: BoxFit.cover)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 16.sp),
                            child: Text(
                              AppLocalisation.username,
                              style: AppTestStyle.headingBai(
                                  color: AppColors.white,
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10.sp),
                            child: Text(
                              AppLocalisation.useremail,
                              style: AppTestStyle.headingint(
                                  color: AppColors.white,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 22.sp,
            ),
            buildClickableText(AppLocalisation.yourplaylist, () {
              context.push("/playlist");
            }),
            buildClickableText(AppLocalisation.events, () {
              context.push("/events");
            }),
            buildClickableText(AppLocalisation.purchase, () {
              context.push("/purchase");
            }),
            buildClickableText(AppLocalisation.rewards, () {
              context.push("/rewards");
            }),
            buildClickableText(AppLocalisation.language, () {
              context.push("/language");
            }),
            buildClickableText(AppLocalisation.help, () {
              context.push("/help");
            }),
            buildClickableText(AppLocalisation.feedback, () {
              context.push("/feedback");
            }),
            buildClickableText(AppLocalisation.contact, () {
              context.push("/contact");
            }),
            SizedBox(
              height: 6.h,
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildClickableText(String text, VoidCallback onPressed) {
  return GestureDetector(
    onTap: onPressed,
    child: Padding(
      padding: EdgeInsets.only(left: 25.sp, bottom: 15.sp),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 24,
          color: AppColors.black,
        ),
      ),
    ),
  );
}
