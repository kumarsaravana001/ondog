// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../config/config_index.dart';

class ElongatedCardWidget extends StatelessWidget {
  final String label;
  final String sublabel;
  final String date;
  final String amount;
  final int cardlength;
  final VoidCallback onPressed;
  final List<Image> imageList;

  const ElongatedCardWidget({
    super.key,
    required this.label,
    required this.sublabel,
    required this.date,
    required this.amount,
    required this.cardlength,
    required this.onPressed,
    required this.imageList,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.sp),
      child: SizedBox(
        child: ListView.builder(
          itemCount: cardlength,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.only(bottom: 10.sp),
              child: Container(
                padding: EdgeInsets.only(bottom: 15.sp),
                height: 24.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.black,
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                        child: imageList[index]),
                    // Column(
                    //   children: [
                    //     Padding(
                    //       padding: const EdgeInsets.all(8.0),
                    //       child: Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Container(
                    //             decoration: BoxDecoration(
                    //               borderRadius: BorderRadius.circular(5),
                    //               color: Colors.black54,
                    //             ),
                    //             child: Padding(
                    //               padding: const EdgeInsets.all(3),
                    //               child: Text(
                    //                 sublabel,
                    //                 style: AppTestStyle.headingint(
                    //                   fontSize: 18.sp,
                    //                   color: AppColors.white,
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //           Row(
                    //             crossAxisAlignment: CrossAxisAlignment.center,
                    //             mainAxisAlignment:
                    //                 MainAxisAlignment.spaceBetween,
                    //             children: [
                    //               Container(
                    //                 decoration: BoxDecoration(
                    //                   borderRadius: BorderRadius.circular(5),
                    //                   color: Colors.black54,
                    //                 ),
                    //                 child: Padding(
                    //                   padding: const EdgeInsets.all(5.0),
                    //                   child: Text(
                    //                     label,
                    //                     style: AppTestStyle.headingBai(
                    //                       fontWeight: FontWeight.bold,
                    //                       fontSize: 24.sp,
                    //                       color: AppColors.white,
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ),
                    //               Container(
                    //                 decoration: BoxDecoration(
                    //                   borderRadius: BorderRadius.circular(5),
                    //                   color: Colors.black54,
                    //                 ),
                    //                 child: Padding(
                    //                   padding: const EdgeInsets.all(5.0),
                    //                   child: Text(
                    //                     AppLocalisation.online,
                    //                     style: AppTestStyle.headingint(
                    //                       fontSize: 18.sp,
                    //                       color: AppColors.white,
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //           SizedBox(height: 1.5.h),
                    //           Container(
                    //             decoration: BoxDecoration(
                    //               borderRadius: BorderRadius.circular(5),
                    //               color: Colors.black54,
                    //             ),
                    //             child: Padding(
                    //               padding: const EdgeInsets.all(5.0),
                    //               child: Text(
                    //                 date,
                    //                 style: AppTestStyle.headingint(
                    //                   fontSize: 18.sp,
                    //                   color: AppColors.white,
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //           Padding(
                    //             padding: EdgeInsets.only(top: 8.sp),
                    //             child: Row(
                    //               mainAxisAlignment:
                    //                   MainAxisAlignment.spaceBetween,
                    //               children: [
                    //                 InkWell(
                    //                   onTap: onPressed,
                    //                   child: Container(
                    //                     decoration: BoxDecoration(
                    //                       borderRadius:
                    //                           BorderRadius.circular(5),
                    //                       color: Colors.black54,
                    //                     ),
                    //                     child: Padding(
                    //                       padding: const EdgeInsets.all(3.0),
                    //                       child: Text(
                    //                         AppLocalisation.openLink,
                    //                         style: AppTestStyle.headingint(
                    //                           underline: true,
                    //                           fontSize: 18.sp,
                    //                           color: AppColors.white,
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   ),
                    //                 ),
                    //                 Container(
                    //                   decoration: BoxDecoration(
                    //                     borderRadius: BorderRadius.circular(5),
                    //                     color: Colors.black54,
                    //                   ),
                    //                   child: Padding(
                    //                     padding: const EdgeInsets.all(5.0),
                    //                     child: Text(
                    //                       amount,
                    //                       style: AppTestStyle.headingint(
                    //                           fontSize: 18.sp,
                    //                           color: AppColors.white),
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
// class ElongatedCardWidgetList extends StatelessWidget {
//   List imagePaths = [
//     AppImages.education(),
//     AppImages.impactandSustainability(),
//     AppImages.legal(),
//     AppImages.travel(),
//   ];

//   ElongatedCardWidgetList({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: imagePaths.length,
//       itemBuilder: (context, index) {
//         return ElongatedCardWidget(
//           imageList: [],
//           label: AppLocalisation.freeentry,
//           sublabel: AppLocalisation.designhinking,
//           date: AppLocalisation.date,
//           amount: AppLocalisation.inramount,
//           onPressed: () {},
//         );
//       },
//     );
//   }
// }
