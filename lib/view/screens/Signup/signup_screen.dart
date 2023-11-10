import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ondgo_flutter/view/screens/profile/profile_screen.dart';

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
            const Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(AppLocalisation.signuptext),
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
                  bottom: -25,
                  left: -15,
                  child: SvgPicture.asset(
                    IconAssets.signupscreenbgdesign,
                    // height: 19.h,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Positioned(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 14.h),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 2.5.h),
                          child: const Text(AppLocalisation.startlearning,
                              style: TextStyle(color: AppColors.white)),
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
                            const Text(
                              AppLocalisation.registernow,
                              style: TextStyle(
                                color: AppColors.white,
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.white,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 1.5.h),
                              child: CustomElevatedButton(
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
