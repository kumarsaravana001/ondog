// ignore_for_file: deprecated_member_use, use_build_context_synchronously, avoid_print
import 'package:flutter/material.dart';
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
  bool showWatchedContent = false;
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
      _isVideoPlaying = true;
      _controller.play();
      _startTimer();
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
            if (!_isVideoPlaying) {
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
              AspectRatio(
                // aspectRatio: _controller.value.aspectRatio,
                aspectRatio: _controller.value.aspectRatio,
                child: _isVideoPlaying
                    ? Chewie(
                        controller: _chewieController,
                      )
                    : Container(),
              ),
              if (!_isVideoPlaying)
                Center(
                    child: Padding(
                  padding: EdgeInsets.only(top: 40.sp),
                  child: const CircularProgressIndicator(),
                )),
            ],
          ),
        ),
      ],
    );
  }
}
