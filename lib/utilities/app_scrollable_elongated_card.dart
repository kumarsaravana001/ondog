import 'package:flutter/material.dart';
import '../config/config_index.dart';

class ScrollableElongatedCardWidget extends StatelessWidget {
  final String label;
  final String sublabel;
  final String sublabel1;
  final VoidCallback onPressed;

  const ScrollableElongatedCardWidget(
      {super.key,
      required this.label,
      required this.sublabel,
      required this.sublabel1,
      required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: EdgeInsets.only(right: 50.sp),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(sublabel,
                          style: AppTestStyle.headingint(
                              fontSize: 18.sp, color: AppColors.white)),
                      SizedBox(height: 7.h),
                      Padding(
                        padding: EdgeInsets.only(top: 8.sp),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(label,
                                style: AppTestStyle.headingint(
                                    fontSize: 18.sp, color: AppColors.white)),
                            Text(sublabel1,
                                style: AppTestStyle.headingint(
                                    fontSize: 18.sp, color: AppColors.white)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 1.h,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8)),
                      color: Colors.purple,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ScrollableElongatedCardWidget1 extends StatelessWidget {
  final String label;
  final String sublabel;
  final String sublabel1;
  final VoidCallback onPressed;

  const ScrollableElongatedCardWidget1({
    super.key,
    required this.label,
    required this.sublabel,
    required this.sublabel1,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  bottom: 15.sp, left: 15.sp, right: 15.sp, top: 20.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(sublabel,
                      style: AppTestStyle.headingint(
                          fontSize: 18.sp, color: AppColors.white)),
                  SizedBox(height: 7.h),
                  Padding(
                    padding: EdgeInsets.only(top: 8.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(label,
                            style: AppTestStyle.headingint(
                                fontSize: 18.sp, color: AppColors.white)),
                        Text(sublabel1,
                            style: AppTestStyle.headingint(
                                fontSize: 18.sp, color: AppColors.white)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 1.h,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8)),
                color: Colors.purple,
              ),
            )
          ],
        ),
      ),
    );
  }
}
