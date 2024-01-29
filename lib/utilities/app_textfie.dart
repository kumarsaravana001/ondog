import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

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
  final int? maxLines;
  final bool showCountryCodePicker;

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
    this.maxLines,
    this.showCountryCodePicker = false,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _isPasswordVisible;
  String? _phoneNumberError;

  @override
  void initState() {
    super.initState();
    _isPasswordVisible = widget.isPasswordVisible;
    _phoneNumberError = null;
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _validatePhoneNumber(String? phone) {
    if (phone == null || phone.isEmpty) {
      _phoneNumberError = 'Mobile Number is required';
    } else if (!RegExp(r'^\+?[0-9]{10,}$').hasMatch(phone)) {
      _phoneNumberError = 'Enter a valid mobile number';
    } else {
      _phoneNumberError = null;
    }
    setState(() {}); // Update the UI to display the error message
  }

  void validatePhoneNumber() {
    _validatePhoneNumber(widget.controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return (widget.showCountryCodePicker)
        ? IntlPhoneField(
            disableLengthCheck: true,
            decoration: InputDecoration(
              errorText: _phoneNumberError,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              filled: true,
              fillColor: Colors.white,
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
            ),
            initialCountryCode: 'IN',
            onChanged: (phone) {
              widget.controller.text = phone.completeNumber;
              _validatePhoneNumber(phone.completeNumber);
            },
          )
        : TextFormField(
            focusNode: widget.focusnode,
            validator: widget.validator,
            controller: widget.controller,
            obscureText: widget.isPassword ? !_isPasswordVisible : false,
            keyboardType: widget.inputType,
            // maxLines: widget.maxLines,
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
          );
  }
}
