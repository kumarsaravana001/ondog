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
        SvgPicture.asset(
          height: 26.sp,
          IconAssets.ondgoTextlogo,
          semanticsLabel: 'Ondgo Logo',
        ),
        SvgPicture.asset(IconAssets.badgecloseblack),
      ],
    );
  }
}
