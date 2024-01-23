import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ondgo_flutter/bloc/login_bloc/login_bloc.dart';
import 'package:ondgo_flutter/bloc/login_bloc/login_event.dart';
import 'package:ondgo_flutter/bloc/login_bloc/login_state.dart';
import 'package:ondgo_flutter/view/screens/homescreen/home.dart';
import '../../../config/config_index.dart';
import '../../../utilities/index.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isPasswordVisible = false;

  void _onLoginButtonPressed() {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<LoginBloc>(context).add(
        LoginWithEmailPassword(
          email: emailController.text,
          password: passwordController.text,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all required fields correctly.'),
          backgroundColor: Colors.red, // Optional: to highlight the error
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginFailure) {
            print('Sign in failed: ${state.error}');
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
              state.error,
            )));
          }
          if (state is LoginSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Login successful'),
            ));

            // Navigate after showing the message
            Future.delayed(const Duration(seconds: 2), () {
              GoRouter.of(context).go('/navbar');
            });
          }
        },
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 50),
                    child: !isKeyboardVisible
                        ? Column(
                            key: const ValueKey('header'),
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 25.sp),
                                child: Text(
                                  AppLocalisation.signuptext,
                                  style: AppTestStyle.headingint(
                                      fontSize: 16.sp, italic: true),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 25.sp),
                                child: SvgPicture.asset(
                                  IconAssets.ondgoTextlogo,
                                  semanticsLabel: 'Ondgo Logo',
                                ),
                              ),
                            ],
                          )
                        : SizedBox(
                            key: const ValueKey('spacer'), height: 25.sp),
                  ),
                  SizedBox(height: 20.h),
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
                        bottom: -40,
                        left: -15,
                        right: -10,
                        child: SvgPicture.asset(
                          IconAssets.signupscreenbgdesign,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      Positioned(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 10.h),
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
                              Padding(
                                padding: EdgeInsets.only(bottom: 18.sp),
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
                              CustomTextField(
                                controller: passwordController,
                                hintText: "Password",
                                borderColor: AppColors.white,
                                isPassword: true,
                                isPasswordVisible: isPasswordVisible,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  // Add more password validation logic if needed
                                  return null;
                                },
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 15.sp),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        context.go("/signup");
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 15.sp),
                                        child: Text(
                                          AppLocalisation.registernow,
                                          style: AppTestStyle.headingint(
                                              fontSize: 16.sp,
                                              color: AppColors.white,
                                              underline: true,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 1.5.h),
                                      child: CustomElevatedButton(
                                          fontsize: 16.sp,
                                          bordercolor: AppColors.white,
                                          backgroundcolor: AppColors.black,
                                          labelcolor: AppColors.white,
                                          text: AppLocalisation.login,
                                          onPressed: _onLoginButtonPressed),
                                    ),
                                  ],
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
      ),
    );
  }
}

class Hometopshapelogin extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.5016667, size.height * -0.0028571);
    path_0.lineTo(size.width * 1.0025000, size.height * 0.2142857);
    path_0.lineTo(size.width * 1.0041667, size.height * 1.0085714);
    path_0.lineTo(size.width * 0.5000000, size.height * 1.0085714);
    path_0.lineTo(size.width * -0.0025000, size.height * 1.0085714);
    path_0.lineTo(size.width * -0.0083333, size.height * 0.2142857);
    path_0.lineTo(size.width * 0.5016667, size.height * -0.0028571);
    path_0.close();

    path_0.close();
    return path_0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
