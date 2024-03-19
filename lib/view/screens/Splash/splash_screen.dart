// // ignore_for_file: library_private_types_in_public_api

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import '../../../config/config_index.dart';

// class SplashScreentwo extends StatefulWidget {
//   const SplashScreentwo({Key? key}) : super(key: key);

//   @override
//   _SplashScreentwoState createState() => _SplashScreentwoState();
// }

// class _SplashScreentwoState extends State<SplashScreentwo> {
//   @override
//   void initState() {
//     super.initState();
//     Timer(const Duration(seconds: 2), () {
//       GoRouter.of(context).go('/signup');
//     });
//   }

// ignore_for_file: library_private_types_in_public_api, deprecated_member_use

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Expanded(
//             child: Center(
//               child: SvgPicture.asset(
//                 IconAssets.ondgoTextlogo,
//                 semanticsLabel: 'Ondgo Logo',
//               ),
//             ),
//           ),
//           const Align(
//             alignment: Alignment.bottomCenter,
//             child: Padding(
//               padding: EdgeInsets.only(bottom: 20.0),
//               child: Text(
//                 AppLocalisation.continues,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../config/config_index.dart';

class SplashScreentwo extends StatefulWidget {
  const SplashScreentwo({Key? key}) : super(key: key);

  @override
  _SplashScreentwoState createState() => _SplashScreentwoState();
}

class _SplashScreentwoState extends State<SplashScreentwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SvgPicture.asset(
              IconAssets.ondgoLogo,
              semanticsLabel: 'Ondgo Logo',
              color: AppColors.black,
            ),
          ),
          SizedBox(height: 8.h),
          Center(
            child: SvgPicture.asset(
              IconAssets.ondgoTextlogo,
              semanticsLabel: 'Ondgo Logo',
            ),
          ),
          SizedBox(height: 5.h),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 50.w,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        side: const BorderSide(
                            color: Colors.black), // Specify border color here
                      ),
                    ),
                  ),
                  onPressed: () {
                    GoRouter.of(context).go('/login');
                  },
                  child: Text(
                    'Login',
                    style: AppTextStyle.headingint(
                        fontSize: 16.sp, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 50.w,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        side: const BorderSide(
                            color: Colors.black), // Specify border color here
                      ),
                    ),
                  ),
                  onPressed: () {
                    GoRouter.of(context).go('/signup');
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.sp),
                    child: Text(
                      'Sign Up',
                      style: AppTextStyle.headingint(
                          fontSize: 16.sp, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 35.0.sp),
                child: Text(
                  AppLocalisation.signuptext,
                  style: AppTextStyle.headingint(fontSize: 16.sp, italic: true),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SplashScreenIntro extends StatefulWidget {
  const SplashScreenIntro({super.key});

  @override
  _SplashScreenIntroState createState() => _SplashScreenIntroState();
}

class _SplashScreenIntroState extends State<SplashScreenIntro> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(microseconds: 5), () {
      navigateToNextScreen();
    });
  }

  void navigateToNextScreen() {
    var box = Hive.box('sessionBox');
    String? userId = box.get('userId');
    String nextRoute = userId != null ? '/navbar' : '/login';
    Navigator.of(context).pushReplacementNamed(nextRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SvgPicture.asset(
              IconAssets.ondgoLogo,
              semanticsLabel: 'Ondgo Logo',
              color: AppColors.black,
            ),
          ),
          SizedBox(height: 8.h),
          Center(
            child: SvgPicture.asset(
              IconAssets.ondgoTextlogo,
              semanticsLabel: 'Ondgo Logo',
            ),
          ),
          SizedBox(height: 5.h),
        ],
      ),
    );
  }
}
