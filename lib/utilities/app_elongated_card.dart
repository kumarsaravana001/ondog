import 'package:flutter/material.dart';
import 'package:ondgo_flutter/utilities/app_banner_list.dart';
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
    Key? key,
    required this.label,
    required this.sublabel,
    required this.date,
    required this.amount,
    required this.onPressed,
    required this.imageList,
    required this.cardlength,
  }) : super(key: key);

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
                height: 21.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.purple,
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                        child: imageList[index]),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                sublabel,
                                style: AppTestStyle.headingint(
                                  fontSize: 18.sp,
                                  color: AppColors.white,
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    label,
                                    style: AppTestStyle.headingBai(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24.sp,
                                      color: AppColors.white,
                                    ),
                                  ),
                                  Text(
                                    AppLocalisation.online,
                                    style: AppTestStyle.headingint(
                                      fontSize: 18.sp,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 1.5.h),
                              Text(
                                date,
                                style: AppTestStyle.headingint(
                                  fontSize: 18.sp,
                                  color: AppColors.white,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 8.sp),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: onPressed,
                                      child: Text(
                                        AppLocalisation.openLink,
                                        style: AppTestStyle.headingint(
                                          underline: true,
                                          fontSize: 18.sp,
                                          color: AppColors.white,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      amount,
                                      style: AppTestStyle.headingint(
                                          fontSize: 18.sp,
                                          color: AppColors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
