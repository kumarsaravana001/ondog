import 'package:flutter/material.dart';
import 'package:ondgo_flutter/config/config_index.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType inputType;
  final bool enabled;
  final TextAlign textAlign;
  final Color borderColor;
  final Color textColor;
  final Color hintColor;
  final double borderRadius;
  final EdgeInsetsGeometry contentPadding;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixIconPressed;
  final FocusNode? focusnode;
  final Function(String?)? onSaved;
  final bool isPassword;
  final bool isPasswordVisible;
  final FormFieldValidator<String>? validator;

  const CustomTextField({
    Key? key,
    this.hintText = 'Enter text',
    required this.controller,
    this.inputType = TextInputType.text,
    this.enabled = true,
    this.textAlign = TextAlign.start,
    this.borderColor = Colors.black,
    this.textColor = Colors.black,
    this.hintColor = Colors.grey,
    this.borderRadius = 30,
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 20.0, vertical: 3.0),
    this.suffixIcon,
    this.onSuffixIconPressed,
    this.focusnode,
    this.onSaved,
    this.isPassword = false,
    this.isPasswordVisible = false,
    this.validator,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _isPasswordVisible;

  @override
  void initState() {
    super.initState();
    _isPasswordVisible = widget.isPasswordVisible;
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8.h,
      child: TextFormField(
        focusNode: widget.focusnode,
        validator: widget.validator,
        controller: widget.controller,
        obscureText: widget.isPassword ? !_isPasswordVisible : false,
        keyboardType: widget.inputType,
        enabled: widget.enabled,
        textAlign: widget.textAlign,
        style: TextStyle(color: widget.textColor),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white, // Background color
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: widget.hintColor,
            fontStyle: FontStyle.italic,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: widget.borderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: widget.borderColor),
          ),
          contentPadding: widget.contentPadding,
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: _togglePasswordVisibility,
                )
              : widget.suffixIcon != null
                  ? IconButton(
                      icon: Icon(widget.suffixIcon),
                      onPressed: widget.onSuffixIconPressed,
                    )
                  : null,
        ),
      ),
    );
  }
}
