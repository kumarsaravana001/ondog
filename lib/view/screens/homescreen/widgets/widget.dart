import 'package:flutter/material.dart';
import 'package:ondgo_flutter/config/config_index.dart';
import 'package:ondgo_flutter/utilities/app_horizontal_scroll_card.dart';
import 'package:shimmer/shimmer.dart';

Widget buildbannerShimmerEffect() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Container(
      height: 71.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}

HorizontalScrollableCard horizontalCardShimmerWidget() {
  int defaultItemCount = 6; // Default item count
  List<String> showNames = List.generate(defaultItemCount, (_) => 'Loading...');
  List<Widget> imageWidgets = List.generate(
    defaultItemCount,
    (_) => Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        color: Colors.white,
        // Adjust the container to match your actual image widgets
      ),
    ),
  );

  return HorizontalScrollableCard(
    cardStatusColor: Colors.indigoAccent,
    titlecard: showNames,
    imageListCount: defaultItemCount,
    imageList: imageWidgets,
    textColor: AppColors.white,
  );
}

Widget buildTextShimmerEffect() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Container(
      height: 25.sp, // Match the size of your text widget
      width: 50.sp, // Adjust the width as per your layout
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.sp),
      ),
    ),
  );
}
