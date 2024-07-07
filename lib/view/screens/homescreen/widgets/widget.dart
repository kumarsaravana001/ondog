import 'package:flutter/material.dart';
import 'package:ondgo_flutter/config/config_index.dart';
import 'package:ondgo_flutter/utilities/app_horizontal_scroll_card.dart';
import 'package:shimmer/shimmer.dart';

Widget buildbannerShimmerEffect() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Container(
      height: 64.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}

Widget buildbannerTileShimmerEffect() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Container(
      height: 30.h,
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
    onTap: (String showId) {},
    showIds: [],
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

class MyShimmerWidget extends StatelessWidget {
  final state; // Assuming this is your state that contains purchaseUrls

  MyShimmerWidget(this.state); // Constructor to get state

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: ListView.builder(
        itemCount: state.purchaseUrls.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!, // Change these colors as needed
              highlightColor:
                  Colors.grey[100]!, // Change these colors as needed
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.white,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    state.purchaseUrls[index].url,
                    fit: BoxFit.cover,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null)
                        return child; // Image is fully loaded
                      return Container(
                        // Placeholder widget
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        width: double.infinity,
                        height: 200, // Specify the height of the placeholder
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
