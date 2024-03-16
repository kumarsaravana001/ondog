import 'package:flutter/material.dart';

import '../../../config/app_localization.dart';
import '../../../config/config_index.dart';

class SigninAssertWidget extends StatelessWidget {
  const SigninAssertWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 25.sp),
          child: Text(
            AppLocalisation.signuptext,
            style: AppTextStyle.headingint(fontSize: 16.sp, italic: true),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 25.sp),
          child: SvgPicture.asset(
            IconAssets.ondgoTextlogo,
            semanticsLabel: 'Ondgo Logo',
          ),
        ),
      ],
    );
  }
}
