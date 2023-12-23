// // import 'package:flutter/material.dart';
// // import 'package:ondgo_flutter/utilities/index.dart';
// // import 'config/config_index.dart';

// // class TestScreen extends StatefulWidget {
// //   const TestScreen({super.key});

// //   @override
// //   State<TestScreen> createState() => _TestScreenState();
// // }

// // class _TestScreenState extends State<TestScreen> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: SafeArea(
// //         child: Padding(
// //           padding: const EdgeInsets.all(10.0),
// //           child: Container(
// //               height: 34.h,
// //               decoration: BoxDecoration(
// //                   color: AppColors.black,
// //                   borderRadius: BorderRadius.circular(20)),
// //               child: SvgPicture.asset(
// //                 IconAssets.scoreicon,
// //                 color: AppColors.black,
// //               )),
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';

// // ... Other imports ...

// class ReelsFullScreen extends StatefulWidget {
//   const ReelsFullScreen({Key? key}) : super(key: key);

//   @override
//   State<ReelsFullScreen> createState() => _ReelsFullScreenState();
// }

// class _ReelsFullScreenState extends State<ReelsFullScreen> {
//   int _currentIndex = 0;
//   final List<String> videoPaths = [
//     'assets/videos/video1.mp4',
//     'assets/videos/video2.mp4',
//     'assets/videos/video3.mp4',
//   ];

//   late VideoPlayerController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.asset(videoPaths[_currentIndex])
//       ..initialize().then((_) {
//         setState(() {});
//       });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   void nextVideo() {
//     if (_currentIndex < videoPaths.length - 1) {
//       setState(() {
//         _currentIndex++;
//         _controller = VideoPlayerController.asset(videoPaths[_currentIndex])
//           ..initialize().then((_) {
//             setState(() {});
//           });
//       });
//     }
//   }

//   void previousVideo() {
//     if (_currentIndex > 0) {
//       setState(() {
//         _currentIndex--;
//         _controller = VideoPlayerController.asset(videoPaths[_currentIndex])
//           ..initialize().then((_) {
//             setState(() {});
//           });
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GestureDetector(
//         // Add your horizontal drag detection here...
//         child: Stack(
//           fit: StackFit.expand,
//           children: [
//             if (_controller.value.isInitialized)
//               AspectRatio(
//                 aspectRatio: _controller.value.aspectRatio,
//                 child: VideoPlayer(_controller),
//               ),
//             // ... Other positioned widgets ...
//           ],
//         ),
//       ),
//     );
//   }
// }
