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
    _pageController = PageController(initialPage: 1, keepPage: true);
    _pageController.addListener(() {
      // Prevent swipe down to page 0 by checking if the page position is attempting to move below 1.
      if (_pageController.page! < 1) {
        _pageController.jumpToPage(
            1); // Force jump back to page 1 if attempt to go to page 0 is detected
      }
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
                  physics: CustomPageViewScrollPhysics(),
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
                            top: 10,
                            left: 20,
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Icon(Icons.arrow_back_outlined,
                                      color: AppColors.white, size: 30),
                                )
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 60.sp,
                            left: 15.sp,
                            child:
                                SvgPicture.asset(IconAssets.reelsleftindicator),
                          ),
                          Positioned(
                            bottom: 43.sp,
                            left: 0,
                            right: 0,
                            child: SvgPicture.asset(
                                IconAssets.reelscenterindicator),
                          ),
                          Positioned(
                            bottom: 60.sp,
                            right: 15.sp,
                            child: SvgPicture.asset(
                                IconAssets.reelsrightindicator),
                          ),
                          Positioned(
                            bottom: 25.sp,
                            left: 15.sp,
                            child: AppIconsWidget.favourites(
                                color: AppColors.white),
                          ),
                          Positioned(
                            bottom: 20.sp,
                            left: 0,
                            right: 0,
                            child: Column(
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
                          Positioned(
                            bottom: 25.sp,
                            right: 15.sp,
                            child: AppIconsWidget.share(color: AppColors.white),
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
                body: Center(
              child: Text("Error loading videos")
              // Text("Error loading videos"),
            ));
          } else {
            return const Scaffold(
                body: Center(child: Text("No videos to display")));
          }
        },
      ),
    );
  }
}

class CustomPageViewScrollPhysics extends ScrollPhysics {
  const CustomPageViewScrollPhysics({ScrollPhysics? parent})
      : super(parent: parent);

  @override
  CustomPageViewScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CustomPageViewScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  bool shouldAcceptUserOffset(ScrollMetrics position) {
    // Prevent swiping to the placeholder/loading page at index 0.
    // This logic assumes the first content page is visually at the start due to initialPage being set to 1.
    // Adjust the threshold as needed based on your content and scrolling behavior.
    if (position.pixels <= 1) {
      return false;
    }
    // Allow scrolling in all other directions.
    return true;
  }
}
