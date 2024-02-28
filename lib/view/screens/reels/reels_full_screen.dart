// ignore_for_file: deprecated_member_use, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ondgo_flutter/bloc/reels_bloc/reels_bloc.dart';
import 'package:ondgo_flutter/bloc/reels_bloc/reels_event.dart';
import 'package:video_player/video_player.dart';
import '../../../bloc/navigation_cubit/navigationbar_cubit.dart';
import '../../../bloc/reels_bloc/reels_state.dart';
import '../../../config/config_index.dart';

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
    _pageController = PageController(initialPage: 1, keepPage: true)
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
    return BlocListener<NavigationCubit, int>(
      listener: (context, state) {
        if (state != 2) {
          _pauseAllVideos();
        }
      },
      child: BlocConsumer<UserReelsBloc, UserReelsState>(
        listener: (context, state) {
          if (state is UserReelsLoaded) {
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
            return SafeArea(
              child: Scaffold(
                body: PageView.builder(
                  controller: _pageController,
                  scrollDirection: Axis.vertical,
                  itemCount: state.reels.length,
                  itemBuilder: (context, index) {
                    final screenHeight = MediaQuery.of(context).size.height;
                    final screenWidth = MediaQuery.of(context).size.width;
                    final videoWidth = screenHeight * (33 / 70);
                    final reel = state.reels[index];
                    if (!_controllers[index].value.isInitialized) {
                      return Container(
                          color: Colors.black,
                          child:
                              const Center(child: CircularProgressIndicator()));
                    }
                    return GestureDetector(
                      onTap: () {
                        if (_controllers[index].value.isPlaying) {
                          _controllers[index].pause();
                        } else {
                          _controllers[index].play();
                        }
                      },
                      child: Stack(
                        children: [
                          // AspectRatio(
                          //   aspectRatio: 33 / 70,
                          //   child: VideoPlayer(_controllers[index]),
                          // ),
                          SizedBox(
                            height: screenHeight, // Full screen height
                            width: videoWidth > screenWidth
                                ? videoWidth
                                : screenWidth, // Full screen width or calculated width
                            child: FittedBox(
                              fit: BoxFit
                                  .fitHeight, // Fit the height to fill the screen vertically
                              child: SizedBox(
                                width: videoWidth,
                                height: screenHeight,
                                child: VideoPlayer(_controllers[index]),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 75,
                            right: 10,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.black45,
                                  borderRadius:
                                      BorderRadiusDirectional.circular(20)),
                              child: Column(
                                children: [
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.playlist_add,
                                        color: AppColors.white,
                                      )),
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.comment,
                                        color: AppColors.white,
                                      )),
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.favorite,
                                        color: AppColors.white,
                                      )),
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.share,
                                        color: AppColors.white,
                                      )),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              color: Colors
                                  .black45, // Semi-transparent background for readability
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    reel.title!,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    reel.description!,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
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
      ),
    );
  }
}
