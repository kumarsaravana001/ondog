import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ondgo_flutter/config/config_index.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

Future<void> logout() async {
  var box = Hive.box('sessionBox');
  await box.delete('userId');
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      SvgPicture.asset(
                        width: MediaQuery.of(context).size.width,
                        IconAssets.profilebg,
                      ),
                      Positioned(
                          top: 0,
                          right: 30,
                          child: SvgPicture.asset(IconAssets.badgecloseblack)),
                      Positioned(
                          bottom: -15.sp,
                          left: MediaQuery.of(context).size.width * 0.5 - 30,
                          child: SvgPicture.asset(
                              IconAssets.proflestandalonelevel)),
                      Positioned(
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 35.sp),
                            child: Column(
                              children: [
                                Container(
                                  width: 40.w,
                                  height: 20.h,
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(12)),
                                      child: AppImages.dummyimage(
                                          fit: BoxFit.cover)),
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
                  SizedBox(height: 32.sp),
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
                  buildClickableText(AppLocalisation.logout, () {
                    logout();
                    context.push("/splash2");
                  }),
                  SizedBox(height: 8.h),
                ],
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.5 - 35.sp,
                left: -10,
                right: -10,
                child: SvgPicture.asset(IconAssets.profilelevels,
                    // ignore: deprecated_member_use
                    color: AppColors.black),
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
      ),
    );
  }
}

Widget buildClickableText(String text, VoidCallback onPressed) {
  return GestureDetector(
    onTap: onPressed,
    child: Padding(
      padding: EdgeInsets.only(left: 25.sp, bottom: 10.sp),
      child: Text(text, style: AppTestStyle.headingBai(fontSize: 22.sp)),
    ),
  );
}
