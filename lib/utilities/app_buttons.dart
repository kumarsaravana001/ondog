import 'package:flutter/material.dart';
import 'package:ondgo_flutter/view/index.dart';
import '../config/app_textstyle.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color backgroundcolor;
  final Color labelcolor;
  final Color bordercolor;
  final double fontsize;
  final FontWeight fontWeight;

  const CustomElevatedButton({
    Key? key,
    required this.text,
    this.onPressed,
    required this.backgroundcolor,
    required this.labelcolor,
    required this.bordercolor,
    required this.fontsize,
    this.fontWeight = FontWeight.w600,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(backgroundcolor),
        side: MaterialStateProperty.all<BorderSide>(
          BorderSide(color: bordercolor, width: 1.5),
        ),
        foregroundColor: MaterialStateProperty.all<Color>(backgroundcolor),
      ),
      child: Text(
        text,
        style: AppTestStyle.headingint(
            fontSize: fontsize.sp,
            fontWeight: FontWeight.w600,
            color: labelcolor),
      ),
    );
  }
}
