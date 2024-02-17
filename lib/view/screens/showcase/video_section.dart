// ignore_for_file: library_private_types_in_public_api, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'package:chewie/chewie.dart';

class MediaWatchSection extends StatefulWidget {
  final String videoUrl;

  const MediaWatchSection({super.key, required this.videoUrl});

  @override
  _MediaWatchSectionState createState() => _MediaWatchSectionState();
}

class _MediaWatchSectionState extends State<MediaWatchSection> {
  late VideoPlayerController _controller;
  late ChewieController _chewieController;

  // @override
  // void initState() {
  //   super.initState();
  //   _controller = VideoPlayerController.network(widget.videoUrl
  //       // 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
  //       // 'https://samplelib.com/lib/preview/mp4/sample-5s.mp4',
  //       )
  //   ..initialize().then((_) {
  //     setState(() {});
  //   });
  //   _chewieController = ChewieController(
  //     videoPlayerController: _controller,
  //     autoPlay: true,
  //     looping: false,
  //   );
  // }
  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  Future<void> initializePlayer() async {
    _controller = VideoPlayerController.network(widget.videoUrl);

    // Wait for the controller to initialize before updating the UI.
    await _controller.initialize();

    // Only proceed to set up ChewieController if the widget is still mounted.
    if (mounted) {
      setState(() {
        _chewieController = ChewieController(
          videoPlayerController: _controller,
          autoPlay: true,
          looping: false,
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

  @override
  void dispose() {
    _controller.dispose();
    _chewieController.dispose();
    super.dispose();
  }
}
