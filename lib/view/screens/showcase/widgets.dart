import 'package:flutter/material.dart';
import '../../../config/config_index.dart';
import 'package:ondgo_flutter/models/showscreen_modules/showscreen_modules.dart';

Widget buildShowDetails(ShowDetailsData? showDetails) {
  if (showDetails == null) return const Text('No details available');
  return Padding(
    padding: EdgeInsets.only(top: 10.sp, left: 18.sp),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          showDetails.showName ?? 'Show Name Not Available',
          style: AppTestStyle.headingBai(
            fontSize: 22.sp,
            color: AppColors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10.sp),
          child: Text(
            showDetails.description ?? 'Description Not Available',
            style: AppTestStyle.headingint(
              fontSize: 17.sp,
              italic: true,
              color: AppColors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10.sp),
              child: Text(
                showDetails.actorArtist ?? 'Description Not Available',
                style: AppTestStyle.headingint(
                  fontSize: 17.sp,
                  italic: true,
                  color: AppColors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.sp, left: 20.sp),
              child: Text(
                showDetails.director ?? 'Description Not Available',
                style: AppTestStyle.headingint(
                  fontSize: 17.sp,
                  italic: true,
                  color: AppColors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
