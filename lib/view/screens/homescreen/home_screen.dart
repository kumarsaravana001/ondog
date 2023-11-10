import 'package:flutter/material.dart';
import '../../../config/config_index.dart';
import '../../../utilities/app_horizontal_scroll_card.dart';
import '../../../utilities/app_scrollable_elongated_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
                child:
                    Center(child: SvgPicture.asset(IconAssets.appbackground))),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(IconAssets.ondgoTextlogo,
                          semanticsLabel: 'Ondgo Logo'),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    height: 30.h,
                    decoration: const BoxDecoration(color: Colors.amber),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 18.sp),
                    child: Text(
                      AppLocalisation.episodes,
                      style: AppTestStyle.headingBai(fontSize: 26.sp),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15.sp),
                    child: ScrollableElongatedCardWidget(
                      label: AppLocalisation.coffeesession,
                      sublabel: AppLocalisation.registernowex,
                      sublabel1: AppLocalisation.interactwithcreators,
                      onPressed: () {},
                    ),
                  ),
                  // ScrollableElongatedCardWidget1(
                  //   label: AppLocalisation.coffeesession,
                  //   sublabel: AppLocalisation.registernowex,
                  //   sublabel1: AppLocalisation.interactwithcreators,
                  //   onPressed: () {},
                  // ),
                  Padding(
                    padding: EdgeInsets.only(left: 18.sp),
                    child: Text(
                      AppLocalisation.events,
                      style: AppTestStyle.headingBai(fontSize: 26.sp),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15.sp),
                    child: HorizontalScrollableCard(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 18.sp),
                    child: Text(
                      AppLocalisation.relatedvideos,
                      style: AppTestStyle.headingBai(fontSize: 26.sp),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15.sp),
                    child: HorizontalScrollableCard(),
                  ),
                ],
              ),
            ),
            // Positioned(
            //     left: 5, top: 65.sp, child: const Icon(Icons.info_outline)),
            // Positioned(
            //   right: 0,
            //   top: 35.sp,
            //   child: const Column(
            //     children: [
            //       Padding(
            //         padding: EdgeInsets.only(bottom: 15),
            //         child: Icon(Icons.favorite),
            //       ),
            //       Padding(
            //         padding: EdgeInsets.only(bottom: 15),
            //         child: Icon(Icons.share),
            //       ),
            //       Padding(
            //         padding: EdgeInsets.only(bottom: 15),
            //         child: Icon(Icons.message),
            //       ),
            //       Padding(
            //         padding: EdgeInsets.only(bottom: 15),
            //         child: Icon(Icons.add),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
