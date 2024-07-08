// // ignore_for_file: library_private_types_in_public_api, deprecated_member_use

// import 'package:flutter/material.dart';
// import 'package:ondgo_flutter/config/app_colors.dart';
// import 'package:video_player/video_player.dart';

// import 'package:chewie/chewie.dart';

// class MediaWatchSection extends StatefulWidget {
//   final String videoUrl;

//   const MediaWatchSection({super.key, required this.videoUrl});

//   @override
//   _MediaWatchSectionState createState() => _MediaWatchSectionState();
// }

// class _MediaWatchSectionState extends State<MediaWatchSection> {
//   late VideoPlayerController _controller;
//   late ChewieController _chewieController;

//   @override
//   void initState() {
//     super.initState();
//     initializePlayer();
//   }

//   Future<void> initializePlayer() async {
//     _controller = VideoPlayerController.network(widget.videoUrl);

//     await _controller.initialize();

//     if (mounted) {
//       setState(() {
//         _chewieController = ChewieController(
//           videoPlayerController: _controller,
//           autoPlay: true,
//           looping: false,
//         );
//       });
//     }
//   }

//   // @override
//   // Widget build(BuildContext context) {
//   //   return Container(
//   //     padding: const EdgeInsets.all(8),
//   //     height: 300,
//   //     child: _controller.value.isInitialized
//   //         ? Chewie(
//   //             controller: _chewieController,
//   //           )
//   //         : const Center(
//   //             child: CircularProgressIndicator(),
//   //           ),
//   //   );
//   // }
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(8),
//       height: 300,
//       child: _controller.value.isInitialized
//           ? Stack(
//               alignment: Alignment.center,
//               children: [
//                 Chewie(
//                   controller: _chewieController,
//                 ),
//                 Positioned(
//                   top: 45,
//                   right: 5,
//                   child: Container(
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         color: AppColors.white),
//                     child: Column(
//                       children: [
//                         // Share Button
//                         IconButton(
//                           icon: const Icon(Icons.share, color: AppColors.black),
//                           onPressed: () {
//                             // Implement your share logic here
//                           },
//                         ),
//                         // Favorites Button
//                         IconButton(
//                           icon: const Icon(Icons.favorite_border,
//                               color: AppColors.black),
//                           onPressed: () {
//                             // Implement your favorites logic here
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             )
//           : const Center(
//               child: CircularProgressIndicator(),
//             ),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     _chewieController.dispose();
//     super.dispose();
//   }
// }
// Widget _buildCustomOverlay() {
//   return Positioned(
//     top: 45,
//     right: 5,
//     child: Container(
//       padding: EdgeInsets.all(5), // For some spacing
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         color: AppColors.white.withOpacity(0.5), // Slightly transparent
//       ),
//       child: Column(
//         children: [
//           IconButton(
//             icon: const Icon(Icons.share, color: AppColors.black),
//             onPressed: () {
//               // Implement your share logic here
//             },
//           ),
//           IconButton(
//             icon: const Icon(Icons.favorite_border, color: AppColors.black),
//             onPressed: () {
//               // Implement your favorites logic here
//             },
//           ),
//         ],
//       ),
//     ),
//   );
// }
import 'package:flutter/material.dart';
import 'package:ondgo_flutter/config/app_colors.dart';
import 'package:ondgo_flutter/config/app_icons_widgets.dart';
import 'package:ondgo_flutter/config/config_index.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class MediaWatchSection extends StatefulWidget {
  final String videoUrl;
  final VoidCallback onVideoStopped;

  const MediaWatchSection({Key? key, required this.videoUrl, required this.onVideoStopped}) : super(key: key);

  @override
  _MediaWatchSectionState createState() => _MediaWatchSectionState();
}

class _MediaWatchSectionState extends State<MediaWatchSection> {
  late VideoPlayerController _controller;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  Future<void> initializePlayer() async {
    _controller = VideoPlayerController.network(widget.videoUrl);
    await _controller.initialize();
    if (mounted) {
      setState(() {
        _chewieController = ChewieController(
          videoPlayerController: _controller,
          autoPlay: true,
          looping: false,
          customControls:
              const MaterialControls(), // Use Chewie's MaterialControls as a base
          overlay: _buildCustomOverlay(), // Overlay for your custom buttons
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: 300,
      child: _controller.value.isInitialized
          ? Chewie(
              controller: _chewieController,
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget _buildCustomOverlay() {
    // This widget builds your custom overlay
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: EdgeInsets.only(top: 35.sp),
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: AppColors.white.withOpacity(0.8),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              )),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 15.sp),
                child: AppIconsWidget.favourites(size: 18),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.sp),
                child: AppIconsWidget.share(size: 18),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.sp),
                child: AppIconsWidget.comment(size: 18),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.sp),
                child: AppIconsWidget.add(size: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _chewieController.dispose();
    super.dispose();
  }
}
