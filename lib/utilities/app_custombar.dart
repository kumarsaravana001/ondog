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
          padding: EdgeInsets.only(top: 8.sp),
          child: SvgPicture.asset(IconAssets.ondgoTextlogo,
              semanticsLabel: 'Ondgo Logo'),
        ),
        InkWell(
            onTap: () {
              // context.push("/profile");
            },
            child:
                SvgPicture.asset(IconAssets.badgecloseblack)),
      ],
    );
  }
}