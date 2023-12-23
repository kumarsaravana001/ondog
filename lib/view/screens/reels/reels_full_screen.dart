import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import '../../../config/config_index.dart';

class ReelsFullScreen extends StatefulWidget {
  const ReelsFullScreen({Key? key}) : super(key: key);

  @override
  State<ReelsFullScreen> createState() => _ReelsFullScreenState();
}

class _ReelsFullScreenState extends State<ReelsFullScreen> {
  int _currentIndex = 0;
  final List<String> videoPaths = [
    'assets/videos/shorts_video1.mp4',
    'assets/videos/shorts_video2.mp4',
    'assets/videos/shorts_video3.mp4',
  ];
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(videoPaths[_currentIndex])
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void nextVideo() {
    if (_currentIndex < videoPaths.length - 1) {
      setState(() {
        _currentIndex++;
        _controller = VideoPlayerController.asset(videoPaths[_currentIndex])
          ..initialize().then((_) {
            setState(() {
              _controller.play();
            });
          });
      });
    }
  }

  void previousVideo() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
        _controller = VideoPlayerController.asset(videoPaths[_currentIndex])
          ..initialize().then((_) {
            setState(() {
              _controller.play();
            });
          });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      body: GestureDetector(
        onHorizontalDragEnd: (DragEndDetails details) {
          if (details.primaryVelocity != null) {
            if (details.primaryVelocity! > 0) {
              previousVideo();
            } else {
              nextVideo();
            }
          }
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: Stack(
              // fit: StackFit.expand,
              children: [
                _controller.value.isInitialized
                    ? VideoPlayer(_controller)
                    : Container(),
                Positioned(
                  bottom: 60.sp,
                  left: 20.sp,
                  child: SvgPicture.asset(IconAssets.reelsleftindicator),
                ),
                Positioned(
                  bottom: 50.sp,
                  left: MediaQuery.of(context).size.width / 2 - 20,
                  child: SvgPicture.asset(IconAssets.reelscenterindicator),
                ),
                Positioned(
                  bottom: 60.sp,
                  right: 20.sp,
                  child: SvgPicture.asset(IconAssets.reelsrightindicator),
                ),
                Positioned(
                  bottom: 35.sp,
                  left: 20.sp,
                  child: AppIconsWidget.favourites(color: AppColors.white),
                ),
                Positioned(
                  bottom: 33.sp,
                  left: MediaQuery.of(context).size.width * 2 / 7,
                  child: Text(
                    AppLocalisation.nutritiondaily,
                    style: AppTestStyle.headingBai(
                      fontSize: 24,
                      color: AppColors.white,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 35.sp,
                  right: 20.sp,
                  child: AppIconsWidget.share(color: AppColors.white),
                ),
                Positioned(
                  bottom: 20.sp,
                  left: MediaQuery.of(context).size.width * 2 / 6,
                  child: Text(
                    AppLocalisation.newepisodes,
                    style: AppTestStyle.headingint(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
