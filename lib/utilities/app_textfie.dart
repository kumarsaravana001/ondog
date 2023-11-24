import 'package:flutter/material.dart';
import 'package:ondgo_flutter/config/config_index.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType inputType;
  final bool enabled;
  final TextAlign textAlign;
  final Color borderColor;
  final Color textColor;
  final Color hintColor;
  final double borderRadius;
  final EdgeInsetsGeometry contentPadding;

  const CustomTextField({
    Key? key,
    this.hintText = 'Enter text',
    required this.controller,
    this.obscureText = false,
    this.inputType = TextInputType.text,
    this.enabled = true,
    this.textAlign = TextAlign.start,
    this.borderColor = Colors.black,
    this.textColor = Colors.black,
    this.hintColor = Colors.grey,
    this.borderRadius = 30,
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        color: AppColors.white,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: inputType,
        enabled: enabled,
        textAlign: textAlign,
        style: TextStyle(color: textColor),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: hintColor,
            fontStyle: FontStyle.italic,
          ),
          border: InputBorder.none,
          contentPadding: contentPadding,
        ),
      ),
    );
  }
}
