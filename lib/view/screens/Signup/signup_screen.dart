import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ondgo_flutter/bloc/signin_bloc/signin_bloc.dart';
import 'package:ondgo_flutter/bloc/signin_bloc/signin_event.dart';
import 'package:ondgo_flutter/bloc/signin_bloc/signin_state.dart';
import 'package:ondgo_flutter/config/config_index.dart';
import 'package:ondgo_flutter/utilities/index.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode mobilenumberFocusNode = FocusNode();
  FocusNode firstNameFocusNode = FocusNode();
  FocusNode lastNameFocusNode = FocusNode();

  ScrollController scrollController = ScrollController();
  bool isPasswordVisible = false;

  final _formKey = GlobalKey<FormState>();

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      context.read<SignInBloc>().add(
            SignInRequested(
              firstName: firstNameController.text,
              lastName: lastNameController.text,
              email: emailController.text,
              password: passwordController.text,
              mobileNumber: mobileController.text,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocListener<SignInBloc, SignInState>(
        listener: (context, state) {
          if (state is SignInFailure) {
            // print('Sign in failed: ${state.errorMessage}');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
          }
          if (state is SignInSuccess) {
            GoRouter.of(context).go('/navbar');
          }
        },
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.all(15.0.sp),
                      child: Text(
                        AppLocalisation.signuptext,
                        style: AppTestStyle.headingint(
                            fontSize: 16.sp, italic: true),
                      ),
                    ),
                  ),
                  Center(
                    child: SvgPicture.asset(IconAssets.ondgoTextlogo,
                        semanticsLabel: 'Ondgo Logo'),
                  ),
                  SizedBox(height: 2.h),
                  Stack(
                    children: [
                      ClipPath(
                        clipper: Hometopshape(),
                        child: Container(
                            height: 93.h,
                            width: double.infinity,
                            color: AppColors.black),
                      ),
                      Positioned(
                        bottom: -25,
                        left: -10,
                        right: -10,
                        child: SvgPicture.asset(IconAssets.signupscreenbgdesign,
                            fit: BoxFit.fitWidth),
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
                                  AppLocalisation.signup,
                                  style: AppTestStyle.headingint(
                                      fontSize: 22.sp,
                                      color: AppColors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              CustomTextField(
                                controller: firstNameController,
                                focusnode: firstNameFocusNode,
                                hintText: "First Name",
                                borderColor: AppColors.white,
                                textColor: AppColors.black,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'First Name is required';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 3.h),
                              CustomTextField(
                                controller: lastNameController,
                                focusnode: lastNameFocusNode,
                                hintText: "Last Name",
                                borderColor: AppColors.white,
                                textColor: AppColors.black,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Last Name is required';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 3.h),
                              CustomTextField(
                                controller: mobileController,
                                focusnode: mobilenumberFocusNode,
                                hintText: "Mobile Number",
                                borderColor: AppColors.white,
                                textColor: AppColors.black,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Mobile Number is required';
                                  }
                                  // You can add regex for validating phone number format
                                  return null;
                                },
                              ),
                              SizedBox(height: 3.h),
                              CustomTextField(
                                controller: emailController,
                                focusnode: emailFocusNode,
                                hintText: "Email",
                                borderColor: AppColors.white,
                                textColor: AppColors.black,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Email is required';
                                  } else if (!RegExp(r'\S+@\S+\.\S+')
                                      .hasMatch(value)) {
                                    return 'Enter a valid Email';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 3.h),
                              CustomTextField(
                                controller: passwordController,
                                focusnode: passwordFocusNode,
                                hintText: "Password",
                                isPassword: true,
                                isPasswordVisible: isPasswordVisible,
                                borderColor: AppColors.white,
                                textColor: AppColors.black,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Password is required';
                                  } else if (value.length < 6) {
                                    return 'Password must be at least 6 characters';
                                  }

                                  return null;
                                },
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 15.sp, top: 22.sp),
                                    child: InkWell(
                                      onTap: () {
                                        context.go("/login");
                                      },
                                      child: Text(
                                        AppLocalisation.alreadyhaveanaccount,
                                        style: AppTestStyle.headingint(
                                            fontSize: 16.sp,
                                            color: AppColors.white,
                                            underline: true,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 3.5.h, right: 10.sp),
                                    child: CustomElevatedButton(
                                      fontsize: 16.sp,
                                      bordercolor: AppColors.white,
                                      backgroundcolor: AppColors.black,
                                      labelcolor: AppColors.white,
                                      text: AppLocalisation.signup,
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          BlocProvider.of<SignInBloc>(context)
                                              .add(
                                            SignInRequested(
                                              firstName:
                                                  firstNameController.text,
                                              lastName: lastNameController.text,
                                              email: emailController.text,
                                              password: passwordController.text,
                                              mobileNumber:
                                                  mobileController.text,
                                            ),
                                          );
                                        }
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
          ),
        ),
      ),
    );
  }
}

class Hometopshape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * -0.0050000, size.height * 1.0100000);
    path_0.lineTo(size.width * 1.0041667, size.height * 1.0028571);
    path_0.lineTo(size.width, size.height * 0.2200000);
    path_0.lineTo(size.width * 0.5016667, size.height * 0.0028571);
    path_0.lineTo(size.width * -0.0016667, size.height * 0.2142857);
    path_0.lineTo(size.width * -0.0108333, size.height * 1.0142857);

    path_0.close();
    return path_0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
