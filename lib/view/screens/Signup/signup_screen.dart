import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../config/config_index.dart';
import '../../../utilities/index.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  AppLocalisation.signuptext,
                  style: AppTestStyle.headingint(fontSize: 16.sp, italic: true),
                ),
              ),
            ),
            const Spacer(),
            Center(
              child: SvgPicture.asset(
                IconAssets.ondgoTextlogo,
                semanticsLabel: 'Ondgo Logo',
              ),
            ),
            SizedBox(height: 2.h),
            Stack(
              children: [
                SvgPicture.asset(
                  IconAssets.signinbottom,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: -40,
                  left: -15,
                  right: -10,
                  child: SvgPicture.asset(
                    IconAssets.signupscreenbgdesign,
                    // height: 19.h,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Positioned(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 5.h),
                          child: Text(
                            AppLocalisation.startlearning,
                            style: AppTestStyle.headingint(
                                fontSize: 22.sp,
                                color: AppColors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        CustomTextField(
                          controller: emailController,
                          hintText: "Email",
                          borderColor: AppColors.white,
                          textColor: AppColors.white,
                        ),
                        SizedBox(height: 3.h),
                        CustomTextField(
                          controller: passwordController,
                          hintText: "Password",
                          borderColor: AppColors.white,
                          textColor: AppColors.white,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 20.sp),
                              child: Text(
                                AppLocalisation.registernow,
                                style: AppTestStyle.headingint(
                                    fontSize: 16.sp,
                                    color: AppColors.white,
                                    underline: true,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 1.5.h),
                              child: CustomElevatedButton(
                                fontsize: 18.sp,
                                bordercolor: AppColors.white,
                                backgroundcolor: AppColors.black,
                                labelcolor: AppColors.white,
                                text: AppLocalisation.login,
                                onPressed: () {
                                  context.go("/Navbar");
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
