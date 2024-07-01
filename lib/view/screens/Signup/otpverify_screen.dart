// import 'package:flutter/material.dart';
// import 'package:supabase/supabase.dart';

// import 'package:ondgo_flutter/view/screens/login/login_screen_widgets.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import '../../../config/config_index.dart';
// import '../../../utilities/app_bg.dart';

// class OtpVerificationScreen extends StatefulWidget {
//     final String mobileNumber;

//   const OtpVerificationScreen({super.key, required this.mobileNumber});

//   @override
//   State<OtpVerificationScreen> createState() => _OtpVerificationScreen();
// }

// class _OtpVerificationScreen extends State<OtpVerificationScreen> {
//   TextEditingController mobileController = TextEditingController();
//    final supabase = Supabase.instance.client;
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
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String mobileNumber;

  OtpVerificationScreen(this.mobileNumber);

  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController _otpController = TextEditingController();
  final supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mobile Number Verification'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Enter OTP sent to ${widget.mobileNumber}'),
              SizedBox(height: 20),
              TextField(
                controller: _otpController,
                decoration: InputDecoration(
                  hintText: 'Enter OTP',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  // Verify OTP
                  final response = await supabase.auth.verifyOTP(
                    type: OtpType.sms,
                  );
                  if (response != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Error verifying OTP: ${response}')),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('OTP Verified Successfully')),
                    );
                    // Navigate to home screen or next step after OTP verification
                  }
                },
                child: Text('Verify OTP'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
