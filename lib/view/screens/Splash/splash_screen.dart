import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../config/config_index.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      GoRouter.of(context).go('/splash1');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Center(
              child: SvgPicture.asset(
                IconAssets.ondgoTextlogo,
                semanticsLabel: 'Ondgo Logo',
              ),
            ),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Text(
                AppLocalisation.continues,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);

//   @override
//   // ignore: library_private_types_in_public_api
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Timer(const Duration(seconds: 2), () {
//       // Navigating using GoRouter instead of Navigator
//       GoRouter.of(context).go('/splash1');
//     });
//   }

//   // Timer(const Duration(seconds: 2), () {
//   //   Navigator.of(context).pushReplacement(
//   //     PageRouteBuilder(
//   //       pageBuilder: (context, animation1, animation2) =>
//   //           const SplashScreen1(),
//   //       transitionsBuilder: (context, animation, secondaryAnimation, child) {
//   //         var begin = Offset.zero;
//   //         //Offset(0.0, 1.0);
//   //         var end = Offset.zero;
//   //         var tween = Tween(begin: begin, end: end).chain(
//   //           CurveTween(curve: Curves.ease),
//   //         );

//   //         return SlideTransition(
//   //           position: animation.drive(tween),
//   //           child: FadeTransition(
//   //             opacity: animation,
//   //             child: child,
//   //           ),
//   //         );
//   //       },
//   //       transitionDuration: const Duration(milliseconds: 800),
//   //     ),
//   //   );
//   // });
// }

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     body: Column(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Expanded(
//           child: Center(
//             child: SvgPicture.asset(
//               IconAssets.ondgoTextlogo,
//               semanticsLabel: 'Ondgo Logo',
//             ),
//           ),
//         ),
//         const Align(
//           alignment: Alignment.bottomCenter,
//           child: Padding(
//             padding: EdgeInsets.only(bottom: 20.0),
//             child: Text(
//               AppLocalisation.continues,
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }

