import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ondgo_flutter/bloc/signin_bloc/signin_bloc.dart';
import 'package:ondgo_flutter/bloc/signin_bloc/signin_event.dart';
import 'package:ondgo_flutter/bloc/signin_bloc/signin_state.dart';
import 'package:ondgo_flutter/config/config_index.dart';
import 'package:ondgo_flutter/utilities/app_bg.dart';
import 'package:ondgo_flutter/utilities/index.dart';
import '../../../utilities/app_validator.dart';
import 'package:hive/hive.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    openBox();
  }

  Future<void> openBox() async {
    await Hive.openBox('userBox');
  }

  Future<void> saveUserData(String firstName, String email) async {
    var box = Hive.box('userBox');
    await box.put('firstName', firstName);
    await box.put('email', email);
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocListener<SignInBloc, SignInState>(
        listener: (context, state) {
          if (state is SignInFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
          }
          if (state is SignInSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Registration successful")),
            );
            Future.delayed(const Duration(seconds: 2), () {
              GoRouter.of(context).go('/login'); // Navigate to the login screen
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
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.all(15.0.sp),
                      child: Text(
                        AppLocalisation.signuptext,
                        style: AppTextStyle.headingint(
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
                        clipper: signupshape(),
                        child: Container(
                            height: 95.h,
                            width: double.infinity,
                            color: AppColors.black),
                      ),
                      Positioned(
                        bottom: -25,
                        left: -10,
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
                                  AppLocalisation.signup,
                                  style: AppTextStyle.headingint(
                                      fontSize: 22.sp,
                                      color: AppColors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              CustomTextField(
                                controller: firstNameController,
                                hintText: "First Name",
                                borderColor: AppColors.white,
                                textColor: AppColors.black,
                                validator: (value) =>
                                    ValidationUtil.validateName(value),
                              ),
                              SizedBox(height: 3.h),
                              CustomTextField(
                                controller: lastNameController,
                                hintText: "Last Name",
                                borderColor: AppColors.white,
                                textColor: AppColors.black,
                                validator: (value) =>
                                    ValidationUtil.validateName(value),
                              ),
                              SizedBox(height: 3.h),
                              CustomTextField(
                                controller: mobileController,
                                showCountryCodePicker: true,
                                hintText: "Mobile Number",
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Mobile Number is required';
                                  } else if (!RegExp(r'^[0-9]{10}$')
                                      .hasMatch(value)) {
                                    return 'Enter a valid 10 digit mobile number';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 3.h),
                              CustomTextField(
                                controller: emailController,
                                hintText: "Email",
                                borderColor: AppColors.white,
                                textColor: AppColors.black,
                                validator: (value) =>
                                    ValidationUtil.validateEmail(value),
                              ),
                              SizedBox(height: 3.h),
                              CustomTextField(
                                controller: passwordController,
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
                                      padding: EdgeInsets.only(top: 15.sp),
                                      child: TextButton(
                                        child: Text(
                                          AppLocalisation.alreadyhaveanacc,
                                          style: AppTextStyle.headingint(
                                              fontSize: 16.sp,
                                              color: AppColors.white,
                                              underline: true,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        onPressed: () {
                                          context.go("/login");
                                        },
                                      )),
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
                                          saveUserData(firstNameController.text,
                                              emailController.text);
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
