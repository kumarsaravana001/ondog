import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ondgo_flutter/utilities/app_buttons.dart';
import 'package:ondgo_flutter/utilities/app_textfie.dart';
import 'package:ondgo_flutter/view/screens/login/login_screen_widgets.dart';
import '../../../config/config_index.dart';
import '../../../utilities/app_bg.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreen();
}

class _ForgetPasswordScreen extends State<ForgetPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SigninAssertWidget(),
                //SizedBox(height: 22.h),
                Stack(
                  children: [
                    ClipPath(
                      clipper: Hometopshapelogin(),
                      child: Container(
                          height: 60.h,
                          width: double.infinity,
                          color: AppColors.black),
                    ),
                    Positioned(
                        bottom: -22,
                        left: -15,
                        right: -10,
                        child: SvgPicture.asset(IconAssets.signupscreenbgdesign,
                            fit: BoxFit.fitWidth)),
                    Positioned(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 10.h),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 2.h),
                              child: Text(
                                AppLocalisation.forgetPassword,
                                style: AppTextStyle.headingint(
                                    fontSize: 21.sp,
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 5.h),
                              child: Text(
                                AppLocalisation.enterotp,
                                style: AppTextStyle.headingint(
                                    fontSize: 15.sp,
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 15.sp),
                              child: CustomTextField(
                                controller: emailController,
                                hintText: "Email",
                                borderColor: AppColors.white,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 1.5.h),
                              child: CustomElevatedButton(
                                fontsize: 16.sp,
                                bordercolor: AppColors.white,
                                backgroundcolor: AppColors.black,
                                labelcolor: AppColors.white,
                                text: AppLocalisation.reset,
                                onPressed: () {
                                  GoRouter.of(context).go('/login');
                                },
                              ),
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
        ),
      ),
    );
  }
}
