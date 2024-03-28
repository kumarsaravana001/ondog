import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ondgo_flutter/bloc/login_bloc/login_bloc.dart';
import 'package:ondgo_flutter/bloc/login_bloc/login_event.dart';
import 'package:ondgo_flutter/bloc/login_bloc/login_state.dart';
import 'package:ondgo_flutter/view/screens/login/login_screen_widgets.dart';
import '../../../config/config_index.dart';
import '../../../utilities/app_bg.dart';
import '../../../utilities/index.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  bool isPasswordVisible = false;
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

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
        SnackBar(
          content: const Text('Please fill in all required fields correctly.'),
          backgroundColor: Colors.red[400],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
          if (state is LoginSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Login successful'),
            ));

            Future.delayed(const Duration(microseconds: 1), () {
              GoRouter.of(context).go('/navbar');
            });
          } else if (state is LoginNoInternet) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('No Internet Connection')));
          }
        },
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SigninAssertWidget(),
                  SizedBox(height: 22.h),
                  Stack(
                    children: [
                      ClipPath(
                        clipper: Hometopshapelogin(),
                        child: Container(
                            height: 58.h,
                            width: double.infinity,
                            color: AppColors.black),
                      ),
                      Positioned(
                          bottom: -40,
                          left: -15,
                          right: -10,
                          child: SvgPicture.asset(
                              IconAssets.signupscreenbgdesign,
                              fit: BoxFit.fitWidth)),
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
                                  style: AppTextStyle.headingint(
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
                                    Padding(
                                        padding: EdgeInsets.only(top: 15.sp),
                                        child: TextButton(
                                          child: Text(
                                            AppLocalisation.registernow,
                                            style: AppTextStyle.headingint(
                                                fontSize: 16.sp,
                                                color: AppColors.white,
                                                underline: true,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          onPressed: () {
                                            context.go("/signup");
                                          },
                                        )),
                                    Padding(
                                      padding: EdgeInsets.only(top: 15.sp),
                                      child: TextButton(
                                        child: Text(
                                          AppLocalisation.forgetPassword,
                                          style: AppTextStyle.headingint(
                                              fontSize: 16.sp,
                                              color: AppColors.white,
                                              underline: true,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        onPressed: () {
                                          context.go("");
                                        },
                                      ),
                                    ),
                                  ],
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
