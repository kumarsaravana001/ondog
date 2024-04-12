import 'package:flutter/material.dart';
import '../config/config_index.dart';

class ScrollableElongatedCardWidget extends StatelessWidget {
  final List<String> label;
  final String sublabel;
  final String sublabel1;
  final int cardlength;
  final VoidCallback onPressed;
  final List<Image> imageList;

  const ScrollableElongatedCardWidget(
      {super.key,
      required this.label,
      required this.sublabel,
      required this.sublabel1,
      required this.imageList,
      required this.onPressed,
      required this.cardlength});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: cardlength,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: 85.w,
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Stack(
                children: [
                  imageList[index],
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Container(
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(5),
                  //           color: Colors.black54,
                  //         ),
                  //         child: Padding(
                  //           padding: const EdgeInsets.all(5),
                  //           child: Text(
                  //             AppLocalisation.registernowex,
                  //             style: AppTestStyle.headingint(
                  //                 color: AppColors.white,
                  //                 fontWeight: FontWeight.w500),
                  //           ),
                  //         ),
                  //       ),
                  //       const Spacer(),
                  //       Container(
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(5),
                  //           color: Colors.black54,
                  //         ),
                  //         child: Padding(
                  //           padding: const EdgeInsets.all(5),
                  //           child: Text(
                  //             label[index],
                  //             style: AppTestStyle.headingBai(
                  //                 color: AppColors.white,
                  //                 fontWeight: FontWeight.w800),
                  //           ),
                  //         ),
                  //       ),
                  //       SizedBox(height: 0.8.h),
                  //       Container(
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(5),
                  //           color: Colors.black54,
                  //         ),
                  //         child: Padding(
                  //           padding: const EdgeInsets.all(5),
                  //           child: Text(
                  //             AppLocalisation.interactwithcreators,
                  //             style: AppTestStyle.headingint(
                  //                 color: AppColors.white,
                  //                 italic: true,
                  //                 fontWeight: FontWeight.w400),
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
