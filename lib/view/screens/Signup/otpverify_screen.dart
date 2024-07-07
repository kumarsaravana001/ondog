// import 'package:flutter/material.dart';
// import 'package:ondgo_flutter/view/screens/login/login_screen_widgets.dart';
// import '../../../config/config_index.dart';
// import '../../../utilities/app_bg.dart';

// class OtpVerificationScreen extends StatefulWidget {
//   const OtpVerificationScreen({super.key});

//   @override
//   State<OtpVerificationScreen> createState() => _OtpVerificationScreen();
// }

// class _OtpVerificationScreen extends State<OtpVerificationScreen> {
//   TextEditingController mobileController = TextEditingController();
//   // final supabase = Supabase.instance.client;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       body: SafeArea(
//         child: Form(
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const SigninAssertWidget(),
//                 //SizedBox(height: 22.h),
//                 Stack(
//                   children: [
//                     ClipPath(
//                       clipper: Hometopshapelogin(),
//                       child: Container(
//                           height: 60.h,
//                           width: double.infinity,
//                           color: AppColors.black),
//                     ),
//                     Positioned(
//                         bottom: -22,
//                         left: -15,
//                         right: -10,
//                         child: SvgPicture.asset(IconAssets.signupscreenbgdesign,
//                             fit: BoxFit.fitWidth)),
//                     Positioned(
//                       child: Padding(
//                         padding: EdgeInsets.symmetric(
//                             horizontal: 8.w, vertical: 10.h),
//                         child: Column(
//                           children: [
//                             Padding(
//                               padding: EdgeInsets.only(bottom: 2.h, top: 2.h),
//                               child: Text(
//                                 AppLocalisation.mobilenumberverify,
//                                 style: AppTextStyle.headingint(
//                                     fontSize: 21.sp,
//                                     color: AppColors.white,
//                                     fontWeight: FontWeight.w400),
//                               ),
//                             ),
//                             Padding(
//                               padding: EdgeInsets.only(bottom: 5.h),
//                               child: Text(
//                                 AppLocalisation.enterotp,
//                                 style: AppTextStyle.headingint(
//                                     fontSize: 15.sp,
//                                     color: AppColors.white,
//                                     fontWeight: FontWeight.w400),
//                               ),
//                             ),
//                             OtpVerificationWidget(
//                               onOtpEntered: (String) {},
//                             ),
//                           ],
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class OtpVerificationWidget extends StatefulWidget {
//   final Function(String) onOtpEntered;

//   const OtpVerificationWidget({Key? key, required this.onOtpEntered})
//       : super(key: key);

//   @override
//   _OtpVerificationWidgetState createState() => _OtpVerificationWidgetState();
// }

// class _OtpVerificationWidgetState extends State<OtpVerificationWidget> {
//   final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
//   final List<TextEditingController> _controllers =
//       List.generate(6, (index) => TextEditingController());
//   bool _isOtpWrong = false;

//   @override
//   void dispose() {
//     for (var controller in _controllers) {
//       controller.dispose();
//     }
//     for (var focusNode in _focusNodes) {
//       focusNode.dispose();
//     }
//     super.dispose();
//   }

//   void _onOtpChanged() {
//     String otp = _controllers.map((controller) => controller.text).join();
//     if (otp.length == 6) {
//       setState(() {
//         _isOtpWrong = false;
//       });
//       widget.onOtpEntered(otp);
//     }
//   }

//   void _verifyOtp() {
//     String otp = _controllers.map((controller) => controller.text).join();
//     if (otp.length == 6) {
//       setState(() {
//         _isOtpWrong = false;
//       });
//       widget.onOtpEntered(otp);
//     } else {
//       setState(() {
//         _isOtpWrong = true;
//       });
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Please enter all 6 digits'),
//       ));
//     }
//   }

//   Widget _buildOtpTextField(int index) {
//     return Container(
//       width: 40,
//       child: TextField(
//         controller: _controllers[index],
//         focusNode: _focusNodes[index],
//         keyboardType: TextInputType.number,
//         textAlign: TextAlign.center,
//         maxLength: 1,
//         style: TextStyle(color: Colors.white),
//         decoration: InputDecoration(
//           counterText: '',
//           filled: true,
//           fillColor: Colors.black,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: BorderSide(
//               color: _isOtpWrong ? Colors.red : Colors.black,
//             ),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: BorderSide(
//               color: Colors.black,
//             ),
//           ),
//         ),
//         onChanged: (value) {
//           if (value.isNotEmpty && index < 5) {
//             _focusNodes[index + 1].requestFocus();
//           }
//           if (value.isEmpty && index > 0) {
//             _focusNodes[index - 1].requestFocus();
//           }
//           _onOtpChanged();
//         },
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: List.generate(6, _buildOtpTextField),
//         ),
//         SizedBox(height: 20),
//         ElevatedButton(
//           onPressed: _verifyOtp,
//           child: Text('Verify'),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ondgo_flutter/config/config_index.dart';
import 'package:ondgo_flutter/utilities/app_bg.dart';
import 'package:ondgo_flutter/utilities/app_buttons.dart';
import 'package:ondgo_flutter/utilities/app_textfie.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key, required this.phoneNumber});
  final String phoneNumber;

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreen();
}

class _OtpVerificationScreen extends State<OtpVerificationScreen> {
  TextEditingController otpController = TextEditingController();
  final supabase = Supabase.instance.client;

  Future<void> verifyOTP(String otp) async {
    final response = await supabase.auth.verifyOTP(
      phone: widget.phoneNumber,
      token: otp,
      type: OtpType.sms,
    );
    // if (response.error != null) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text(response.error!.message)),
    //   );
    // } else
    {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('OTP verification successful')),
      );
      context.go('/signup');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.all(15.0.sp),
                  child: Text(
                    'OTP Verification',
                    style:
                        AppTextStyle.headingint(fontSize: 16.sp, italic: true),
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 5.h),
                            child: Text(
                              'Enter OTP',
                              style: AppTextStyle.headingint(
                                  fontSize: 22.sp,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          CustomTextField(
                            controller: otpController,
                            hintText: "Enter OTP",
                            borderColor: AppColors.white,
                            textColor: AppColors.black,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'OTP is required';
                              } else if (value.length != 6) {
                                return 'OTP must be 6 digits';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 3.h),
                          CustomElevatedButton(
                            fontsize: 16.sp,
                            bordercolor: AppColors.white,
                            backgroundcolor: AppColors.black,
                            labelcolor: AppColors.white,
                            text: 'Verify OTP',
                            onPressed: () async {
                              if (otpController.text.length == 6) {
                                await verifyOTP(otpController.text);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Invalid OTP')),
                                );
                              }
                            },
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
    );
  }
}
