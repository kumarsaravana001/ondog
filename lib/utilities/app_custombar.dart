import 'package:flutter/material.dart';

import '../config/config_index.dart';

class CustomeAppBar extends StatelessWidget {
  const CustomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 18.sp),
          child: SvgPicture.asset(
            height: 26.sp,
            IconAssets.ondgoTextlogo,
            semanticsLabel: 'Ondgo Logo',
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 22.sp),
          child: SvgPicture.asset(IconAssets.badgecloseblack),
        ),
      ],
    );
  }
}
