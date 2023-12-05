import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ondgo_flutter/view/screens/showcase/showcase_screen.dart';

import '../../../config/config_index.dart';

class MediaWatchSection extends StatefulWidget {
  const MediaWatchSection({super.key});

  @override
  State<MediaWatchSection> createState() => _MediaWatchSectionState();
}

class _MediaWatchSectionState extends State<MediaWatchSection> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppImages.dummyimage(width: MediaQuery.of(context).size.width),
        Positioned(
          left: 10,
          bottom: 20,
          child: GestureDetector(
            onTap: () {},
            child: const Icon(
              Icons.info_outline,
              color: AppColors.white,
            ),
          ),
        ),
        Positioned(
            right: 0,
            top: 30,
            child: Container(
              decoration: const BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AppIconsWidget.favourites()),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                        onTap: () {
                          setState(() {
                            showWatchedContent = false;
                          });
                        },
                        child: AppIconsWidget.share()),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AppIconsWidget.message()),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AppIconsWidget.addtoplaylist()),
                ],
              ),
            ))
      ],
    );
  }
}
