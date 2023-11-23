import 'package:flutter/material.dart';
import 'package:ondgo_flutter/utilities/app_banner_list.dart';
import '../config/config_index.dart';

class AppVerticalScrollCard extends StatelessWidget {
  const AppVerticalScrollCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          mainAxisExtent: 200),
      itemCount: allimagePaths.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          decoration: BoxDecoration(
              color: AppColors.black,
              borderRadius: BorderRadius.circular(15.0)),
          child: Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 10.sp, horizontal: 14.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppLocalisation.finance,
                            style: AppTestStyle.headingint(
                                fontSize: 16.sp,
                                color: AppColors.white,
                                fontWeight: FontWeight.bold)),
                        Text(AppLocalisation.ddmm,
                            style: AppTestStyle.headingint(
                                fontSize: 16.sp,
                                color: AppColors.white,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                    Text(AppLocalisation.commingsoon,
                        style: AppTestStyle.headingint(
                            fontSize: 15.sp,
                            color: AppColors.white,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return SizedBox(
                    width: constraints.maxWidth,
                    height:
                        constraints.maxWidth, // Assuming you want square images
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: allimagePaths[index], // Your image here
                      ),
                    ),
                  );
                },
              ),
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15)),
                child: Container(
                  height: 10,
                  color: Colors.purple,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
