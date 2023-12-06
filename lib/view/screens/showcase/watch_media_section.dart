// ignore_for_file: deprecated_member_use, use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:ondgo_flutter/view/screens/showcase/showcase_screen.dart';
import 'package:video_player/video_player.dart';
import 'package:connectivity/connectivity.dart';
import '../../../config/config_index.dart';
import 'dart:async';
import 'package:chewie/chewie.dart';

class MediaWatchSection extends StatefulWidget {
  const MediaWatchSection({Key? key}) : super(key: key);

  @override
  State<MediaWatchSection> createState() => _MediaWatchSectionState();
}

class _MediaWatchSectionState extends State<MediaWatchSection> {
  late VideoPlayerController _controller;
  bool _isVideoPlaying = false;
  bool _isInitializing = true;
  bool _showControls = true;
  late Timer _timer;
  late ChewieController _chewieController;
  @override
  void initState() {
    super.initState();
    _initializeVideo();
    _checkInternetConnection();
  }

  Future<void> _initializeVideo() async {
    try {
      _controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      );
      await _controller.initialize();
      setState(() {
        _isInitializing = false;
      });
      _chewieController = ChewieController(
        videoPlayerController: _controller,
        autoPlay: false, // Set to true if you want autoplay
        looping: false, // Set to true if you want looping
        allowFullScreen: true, // Enable fullscreen
        allowMuting: true, // Enable muting
        placeholder: Container(), // Optional placeholder widget
      );
    } catch (e) {
      print('Error initializing video: $e');
    }
  }

  Future<void> _checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No internet connection'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  void _togglePlayPause() {
    setState(() {
      _isVideoPlaying ? _controller.pause() : _controller.play();
      _isVideoPlaying = !_isVideoPlaying;
      _showControls = true;
      _startTimer();
    });
  }

  void _startTimer() {
    if (_timer.isActive) {
      _timer.cancel();
    }
    _timer = Timer(const Duration(seconds: 3), () {
      setState(() {
        _showControls = false;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            if (!_isVideoPlaying && !_isInitializing) {
              setState(() {
                _isVideoPlaying = true;
                _controller.play();
              });
              _startTimer();
            } else {
              setState(() {
                _showControls = !_showControls;
              });
              _startTimer();
            }
          },
          child: Stack(
            children: [
              _isVideoPlaying
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: Chewie(
                        controller: _chewieController,
                      ),
                      //VideoPlayer(_controller),
                    )
                  : AppImages.dummyimage(
                      width: MediaQuery.of(context).size.width,
                    ),
              if (_showControls)
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 35.sp),
                    child: IconButton(
                      icon: _isVideoPlaying
                          ? const Icon(Icons.pause)
                          : const Icon(Icons.play_arrow),
                      iconSize: 64,
                      onPressed: _togglePlayPause,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
        ),
        Positioned(
          right: 0,
          top: 30,
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppIconsWidget.favourites(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        showWatchedContent = false;
                      });
                    },
                    child: AppIconsWidget.share(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppIconsWidget.message(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppIconsWidget.addtoplaylist(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// class MediaWatchSection extends StatefulWidget {
//   const MediaWatchSection({super.key});

//   @override
//   State<MediaWatchSection> createState() => _MediaWatchSectionState();
// }

// class _MediaWatchSectionState extends State<MediaWatchSection> {
//   late VideoPlayerController _controller;
//   bool _isVideoPlaying = false;
//   bool _isInitializing = true;
//   @override
//   void initState() {
//     super.initState();
//     _initializeVideo();
//     _checkInternetConnection();
//   }

//   Future<void> _initializeVideo() async {
//     try {
//       _controller = VideoPlayerController.network(
//         'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
//       );
//       await _controller.initialize();
//       setState(() {
//         _isInitializing = false;
//       });
//     } catch (e) {
//       print('Error initializing video: $e');
//     }
//   }

//   Future<void> _checkInternetConnection() async {
//     var connectivityResult = await Connectivity().checkConnectivity();
//     if (connectivityResult == ConnectivityResult.none) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('No internet connection'),
//           duration: Duration(seconds: 3),
//         ),
//       );
//     }
//   }

//   void _togglePlayPause() {
//     setState(() {
//       _isVideoPlaying ? _controller.pause() : _controller.play();
//       _isVideoPlaying = !_isVideoPlaying;
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         GestureDetector(
//           onTap: () {
//             if (!_isVideoPlaying && !_isInitializing) {
//               setState(() {
//                 _isVideoPlaying = true;
//                 _controller.play();
//               });
//             }
//           },
//           child: Stack(
//             children: [
//               _isVideoPlaying
//                   ? AspectRatio(
//                       aspectRatio: _controller.value.aspectRatio,
//                       child: VideoPlayer(_controller),
//                     )
//                   : AppImages.dummyimage(
//                       width: MediaQuery.of(context).size.width,
//                     ),
//               Center(
//                 child: Padding(
//                   padding: EdgeInsets.only(top: 35.sp),
//                   child: IconButton(
//                     icon: _isVideoPlaying
//                         ? const Icon(Icons.pause)
//                         : const Icon(Icons.play_arrow),
//                     iconSize: 64,
//                     onPressed: _togglePlayPause,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         if (_isVideoPlaying)
//           Positioned.fill(
//             child: GestureDetector(
//               onTap: () {
//                 setState(() {
//                   _isVideoPlaying = false;
//                   _controller.pause();
//                 });
//               },
//               child: Container(
//                 color: Colors.transparent,
//               ),
//             ),
//           ),
//         Positioned(
//             right: 0,
//             top: 30,
//             child: Container(
//               decoration: const BoxDecoration(
//                   color: AppColors.white,
//                   borderRadius: BorderRadius.all(Radius.circular(5))),
//               child: Column(
//                 children: [
//                   Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: AppIconsWidget.favourites()),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: InkWell(
//                         onTap: () {
//                           setState(() {
//                             showWatchedContent = false;
//                           });
//                         },
//                         child: AppIconsWidget.share()),
//                   ),
//                   Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: AppIconsWidget.message()),
//                   Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: AppIconsWidget.addtoplaylist()),
//                 ],
//               ),
//             ))
//       ],
//     );
//   }
// }
