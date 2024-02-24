// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ondgo_flutter/bloc/reels_bloc/reels_bloc.dart';
import 'package:ondgo_flutter/bloc/reels_bloc/reels_event.dart';
import 'package:video_player/video_player.dart';
import '../../../bloc/reels_bloc/reels_state.dart';

class ShortsPage extends StatefulWidget {
  const ShortsPage({super.key});

  @override
  _ShortsPageState createState() => _ShortsPageState();
}

class _ShortsPageState extends State<ShortsPage> with WidgetsBindingObserver {
  late PageController _pageController;
  List<VideoPlayerController> _controllers = [];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0, keepPage: true)
      ..addListener(() {
        setState(() {
          _handlePageChange(_pageController.page!.round());
        });
      });
    WidgetsBinding.instance.addObserver(this);
    context.read<UserReelsBloc>().add(FetchUserReels());
  }

  void _initializeVideoPlayers(List<String> videoUrls) {
    _controllers = videoUrls.map((videoUrl) {
      final controller = VideoPlayerController.network(videoUrl)
        ..initialize().then((_) {
          if (mounted) setState(() {});
        })
        ..setLooping(true);
      return controller;
    }).toList();
  }

  void _handlePageChange(int index) {
    if (!_pageController.hasClients || _pageController.page == null) return;
    // Your existing logic
  }

  void _playAllVideos() {
    for (var controller in _controllers) {
      if (!controller.value.isPlaying) {
        controller.play();
      }
    }
  }

  void _pauseAllVideos() {
    for (var controller in _controllers) {
      if (controller.value.isPlaying) {
        controller.pause();
      }
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserReelsBloc, UserReelsState>(
      listener: (context, state) {
        if (state is UserReelsLoaded) {
          // Ensure we only include non-null video URLs
          final videoUrls = state.reels
              .map((reel) => reel.videoUrl)
              .where((url) => url != null)
              .cast<String>()
              .toList();
          _initializeVideoPlayers(videoUrls);
        }
      },
      builder: (context, state) {
        if (state is UserReelsLoading) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        } else if (state is UserReelsLoaded) {
          return Scaffold(
            body: PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.vertical,
              itemCount: _controllers.length,
              itemBuilder: (context, index) {
                if (!_controllers[index].value.isInitialized) {
                  return Container(
                    color: Colors.black,
                    child: const Center(child: CircularProgressIndicator()),
                  );
                }
                return GestureDetector(
                  onTap: () {
                    if (_controllers[index].value.isPlaying) {
                      _controllers[index].pause();
                    } else {
                      _controllers[index].play();
                    }
                  },
                  child: AspectRatio(
                    aspectRatio: _controllers[index].value.aspectRatio,
                    child: VideoPlayer(_controllers[index]),
                  ),
                );
              },
            ),
          );
        } else if (state is UserReelsError) {
          return const Scaffold(
              body: Center(child: Text("Error loading videos")));
        } else {
          return const Scaffold(
              body: Center(child: Text("No videos to display")));
        }
      },
    );
  }
}
