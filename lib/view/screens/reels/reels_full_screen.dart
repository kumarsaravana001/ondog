import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

import '../../../bloc/navigation_cubit/navigationbar_cubit.dart';

class ShortsPage extends StatefulWidget {
  const ShortsPage({super.key});

  @override
  _ShortsPageState createState() => _ShortsPageState();
}

class _ShortsPageState extends State<ShortsPage> with WidgetsBindingObserver {
  late PageController _pageController;

  final List<String> videoPaths = [
    'assets/videos/shorts_video1.mp4',
    'assets/videos/shorts_video2.mp4',
    'assets/videos/shorts_video3.mp4',
  ];

  List<VideoPlayerController> _controllers = [];

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayers();
    _pageController = PageController(initialPage: 0, keepPage: true)
      ..addListener(() {
        setState(() {
          _handlePageChange(_pageController.page!.round());
        });
      });
    WidgetsBinding.instance.addObserver(this);
  }

  void _handlePageChange(int index) {
    if (!_pageController.hasClients || _pageController.page == null) return;

    if (_pageController.page!.round() != _controllers.length - 1) {
      _pauseAllVideos();
    } else {
      _playAllVideos();
    }
  }

  void _playAllVideos() {
    for (var controller in _controllers) {
      if (!controller.value.isPlaying) {
        controller.play();
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
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      _pauseAllVideos();
    }
  }

  void _pauseAllVideos() {
    _controllers.forEach((controller) {
      if (controller.value.isPlaying) {
        controller.pause();
      }
    });
  }

  void _initializeVideoPlayers() {
    for (var videoPath in videoPaths) {
      VideoPlayerController controller = VideoPlayerController.asset(videoPath)
        ..initialize().then((_) {
          setState(() {});
        })
        ..setLooping(true);
      _controllers.add(controller);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NavigationCubit, int>(
      listener: (context, state) {
        if (state != 2) {
          _pauseAllVideos();
        }
      },
      child: Scaffold(
        body: PageView.builder(
          controller: _pageController,
          scrollDirection: Axis.vertical,
          itemCount: videoPaths.length,
          itemBuilder: (context, index) {
            // Check if the controller is initialized
            if (!_controllers[index].value.isInitialized) {
              return Container(
                color: Colors.black,
                child: const Center(child: CircularProgressIndicator()),
              );
            }

            return GestureDetector(
              onTap: () {
                // Check the current playing state and toggle between play and pause
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
      ),
    );
  }
}
