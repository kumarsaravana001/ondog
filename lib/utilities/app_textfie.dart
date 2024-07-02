// import 'package:flutter/material.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
// import 'package:intl_phone_field/phone_number.dart';

// class CustomTextField extends StatefulWidget {
//   const CustomTextField({
//     Key? key,
//     this.hintText = 'Enter text',
//     required this.controller,
//     this.inputType = TextInputType.text,
//     this.enabled = true,
//     this.textAlign = TextAlign.start,
//     this.borderColor = Colors.black,
//     this.textColor = Colors.black,
//     this.hintColor = Colors.grey,
//     this.borderRadius = 30,
//     this.contentPadding =
//         const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
//     this.suffixIcon,
//     this.onSuffixIconPressed,
//     this.focusnode,
//     this.onSaved,
//     this.isPassword = false,
//     this.isPasswordVisible = false,
//     this.validator,
//     this.maxLines,
//     this.showCountryCodePicker = false,
//   }) : super(key: key);

//   final Function(String?)? onSaved;
//   final Color borderColor;
//   final double borderRadius;
//   final EdgeInsetsGeometry contentPadding;
//   final TextEditingController controller;
//   final bool enabled;
//   final FocusNode? focusnode;
//   final Color hintColor;
//   final String hintText;
//   final TextInputType inputType;
//   final bool isPassword;
//   final bool isPasswordVisible;
//   final int? maxLines;
//   final VoidCallback? onSuffixIconPressed;
//   final bool showCountryCodePicker;
//   final IconData? suffixIcon;
//   final TextAlign textAlign;
//   final Color textColor;
//   final FormFieldValidator<String>? validator;

//   @override
//   State<CustomTextField> createState() => _CustomTextFieldState();
// }

// class _CustomTextFieldState extends State<CustomTextField> {
//   late bool _isPasswordVisible;

//   @override
//   void initState() {
//     super.initState();
//     _isPasswordVisible = widget.isPasswordVisible;
//   }

//   void _togglePasswordVisibility() {
//     setState(() {
//       _isPasswordVisible = !_isPasswordVisible;
//     });
//   }

//   String? phoneInputValidator(PhoneNumber? phone) {
//     if (phone == null || phone.completeNumber.isEmpty) {
//       return 'Mobile Number is required';
//     }
//     try {
//       var phoneNumber =
//           int.parse(phone.number); // Parse the phone number to int
//       if (phone.number.length != 10) {
//         return 'Enter a valid 10 digit mobile number';
//       }
//     } catch (e) {
//       return 'Enter a valid mobile number'; // In case of non-numeric characters
//     }
//     return null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return (widget.showCountryCodePicker)
//         // ? IntlPhoneField(
//         //     autovalidateMode: AutovalidateMode.onUserInteraction,
//         //     disableLengthCheck: true,
//         //     decoration: InputDecoration(
//         //       floatingLabelBehavior: FloatingLabelBehavior.always,
//         //       filled: true,
//         //       fillColor: Colors.white,
//         //       hintText: widget.hintText,
//         //       hintStyle: TextStyle(
//         //         color: widget.hintColor,
//         //         fontStyle: FontStyle.italic,
//         //       ),
//         //       border: OutlineInputBorder(
//         //           borderRadius: BorderRadius.circular(25),
//         //           borderSide: BorderSide.none),
//         //       enabledBorder: OutlineInputBorder(
//         //           borderRadius: BorderRadius.circular(25),
//         //           borderSide: BorderSide(color: widget.borderColor)),
//         //       focusedBorder: OutlineInputBorder(
//         //           borderRadius: BorderRadius.circular(25),
//         //           borderSide: BorderSide(color: widget.borderColor)),
//         //       contentPadding: widget.contentPadding,
//         //     ),
//         //     initialCountryCode: 'IN',
//         //     onChanged: (phone) {
//         //       widget.controller.text = phone.completeNumber;
//         //     },
//         //     validator: phoneInputValidator,
//         //   )
//         ? IntlPhoneField(
//             autovalidateMode: AutovalidateMode.onUserInteraction,
//             disableLengthCheck: true,
//             decoration: InputDecoration(
//               floatingLabelBehavior: FloatingLabelBehavior.always,
//               filled: true,
//               fillColor: Colors.white,
//               hintText: widget.hintText,
//               hintStyle: TextStyle(
//                 color: widget.hintColor,
//                 fontStyle: FontStyle.italic,
//               ),
//               border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(25),
//                   borderSide: BorderSide.none),
//               enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(25),
//                   borderSide: BorderSide(color: widget.borderColor)),
//               focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(25),
//                   borderSide: BorderSide(color: widget.borderColor)),
//               contentPadding: widget.contentPadding,
//             ),
//             initialCountryCode: 'IN',
//             onChanged: (phone) {
//               // Update to set only the mobile number without country code
//               widget.controller.text = phone.number;
//             },
//             validator: phoneInputValidator,
//           )
//         : TextFormField(
//             focusNode: widget.focusnode,
//             validator: widget.validator,
//             controller: widget.controller,
//             obscureText: widget.isPassword ? !_isPasswordVisible : false,
//             keyboardType: widget.inputType,
//             enabled: widget.enabled,
//             textAlign: widget.textAlign,
//             style: TextStyle(color: widget.textColor),
//             decoration: InputDecoration(
//               filled: true,
//               fillColor: Colors.white,
//               hintText: widget.hintText,
//               hintStyle: TextStyle(
//                 color: widget.hintColor,
//                 fontStyle: FontStyle.italic,
//               ),
//               border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(25),
//                   borderSide: BorderSide.none),
//               enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(25),
//                   borderSide: BorderSide(color: widget.borderColor)),
//               focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(25),
//                   borderSide: BorderSide(color: widget.borderColor)),
//               contentPadding: widget.contentPadding,
//               suffixIcon: widget.isPassword
//                   ? IconButton(
//                       icon: Icon(
//                         _isPasswordVisible
//                             ? Icons.visibility
//                             : Icons.visibility_off,
//                       ),
//                       onPressed: _togglePasswordVisibility,
//                     )
//                   : widget.suffixIcon != null
//                       ? IconButton(
//                           icon: Icon(widget.suffixIcon),
//                           onPressed: widget.onSuffixIconPressed,
//                         )
//                       : null,
//             ),
//           );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
// import 'package:intl_phone_field/phone_number.dart';

// class CustomTextField extends StatefulWidget {
//   const CustomTextField({
//     Key? key,
//     this.hintText = 'Enter text',
//     required this.controller,
//     this.inputType = TextInputType.text,
//     this.enabled = true,
//     this.textAlign = TextAlign.start,
//     this.borderColor = Colors.black,
//     this.textColor = Colors.black,
//     this.hintColor = Colors.grey,
//     this.borderRadius = 30,
//     this.contentPadding =
//         const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
//     this.suffixIcon,
//     this.suffixWidget,
//     this.onSuffixIconPressed,
//     this.focusnode,
//     this.onSaved,
//     this.isPassword = false,
//     this.isPasswordVisible = false,
//     this.validator,
//     this.maxLines,
//     this.showCountryCodePicker = false,
//   }) : super(key: key);

//   final Function(String?)? onSaved;
//   final Color borderColor;
//   final double borderRadius;
//   final EdgeInsetsGeometry contentPadding;
//   final TextEditingController controller;
//   final bool enabled;
//   final FocusNode? focusnode;
//   final Color hintColor;
//   final String hintText;
//   final TextInputType inputType;
//   final bool isPassword;
//   final bool isPasswordVisible;
//   final int? maxLines;
//   final VoidCallback? onSuffixIconPressed;
//   final bool showCountryCodePicker;
//   final IconData? suffixIcon;
//   final Widget? suffixWidget;
//   final TextAlign textAlign;
//   final Color textColor;
//   final FormFieldValidator<String>? validator;

//   @override
//   State<CustomTextField> createState() => _CustomTextFieldState();
// }

// class _CustomTextFieldState extends State<CustomTextField> {
//   late bool _isPasswordVisible;

//   @override
//   void initState() {
//     super.initState();
//     _isPasswordVisible = widget.isPasswordVisible;
//   }

//   void _togglePasswordVisibility() {
//     setState(() {
//       _isPasswordVisible = !_isPasswordVisible;
//     });
//   }

//   String? phoneInputValidator(PhoneNumber? phone) {
//     if (phone == null || phone.completeNumber.isEmpty) {
//       return 'Mobile Number is required';
//     }
//     try {
//       var phoneNumber =
//           int.parse(phone.number); // Parse the phone number to int
//       if (phone.number.length != 10) {
//         return 'Enter a valid 10 digit mobile number';
//       }
//     } catch (e) {
//       return 'Enter a valid mobile number'; // In case of non-numeric characters
//     }
//     return null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return (widget.showCountryCodePicker)
//         ? IntlPhoneField(
//             autovalidateMode: AutovalidateMode.onUserInteraction,
//             disableLengthCheck: true,
//             decoration: InputDecoration(
//               floatingLabelBehavior: FloatingLabelBehavior.always,
//               filled: true,
//               fillColor: Colors.white,
//               hintText: widget.hintText,
//               hintStyle: TextStyle(
//                 color: widget.hintColor,
//                 fontStyle: FontStyle.italic,
//               ),
//               border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(25),
//                   borderSide: BorderSide.none),
//               enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(25),
//                   borderSide: BorderSide(color: widget.borderColor)),
//               focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(25),
//                   borderSide: BorderSide(color: widget.borderColor)),
//               contentPadding: widget.contentPadding,
//               suffixIcon: widget.suffixWidget,
//             ),
//             initialCountryCode: 'IN',
//             onChanged: (phone) {
//               widget.controller.text = phone.number;
//             },
//             validator: phoneInputValidator,
//           )
//         : TextFormField(
//             focusNode: widget.focusnode,
//             validator: widget.validator,
//             controller: widget.controller,
//             obscureText: widget.isPassword ? !_isPasswordVisible : false,
//             keyboardType: widget.inputType,
//             enabled: widget.enabled,
//             textAlign: widget.textAlign,
//             style: TextStyle(color: widget.textColor),
//             decoration: InputDecoration(
//               filled: true,
//               fillColor: Colors.white,
//               hintText: widget.hintText,
//               hintStyle: TextStyle(
//                 color: widget.hintColor,
//                 fontStyle: FontStyle.italic,
//               ),
//               border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(25),
//                   borderSide: BorderSide.none),
//               enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(25),
//                   borderSide: BorderSide(color: widget.borderColor)),
//               focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(25),
//                   borderSide: BorderSide(color: widget.borderColor)),
//               contentPadding: widget.contentPadding,
//               suffixIcon: widget.isPassword
//                   ? IconButton(
//                       icon: Icon(
//                         _isPasswordVisible
//                             ? Icons.visibility
//                             : Icons.visibility_off,
//                       ),
//                       onPressed: _togglePasswordVisibility,
//                     )
//                   : widget.suffixIcon != null
//                       ? IconButton(
//                           icon: Icon(widget.suffixIcon),
//                           onPressed: widget.onSuffixIconPressed,
//                         )
//                       : widget.suffixWidget,
//             ),
//           );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
// import 'package:intl_phone_field/phone_number.dart';

// class CustomTextField extends StatefulWidget {
//   const CustomTextField({
//     Key? key,
//     this.hintText = 'Enter text',
//     required this.controller,
//     this.inputType = TextInputType.text,
//     this.enabled = true,
//     this.textAlign = TextAlign.start,
//     this.borderColor = Colors.black,
//     this.textColor = Colors.black,
//     this.hintColor = Colors.grey,
//     this.borderRadius = 30,
//     this.contentPadding = const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
//     this.suffixIcon,
//     this.suffixWidget,
//     this.onSuffixIconPressed,
//     this.focusnode,
//     this.onSaved,
//     this.isPassword = false,
//     this.isPasswordVisible = false,
//     this.validator,
//     this.maxLines,
//     this.showCountryCodePicker = false,
//   }) : super(key: key);

//   final Function(String?)? onSaved;
//   final Color borderColor;
//   final double borderRadius;
//   final EdgeInsetsGeometry contentPadding;
//   final TextEditingController controller;
//   final bool enabled;
//   final FocusNode? focusnode;
//   final Color hintColor;
//   final String hintText;
//   final TextInputType inputType;
//   final bool isPassword;
//   final bool isPasswordVisible;
//   final int? maxLines;
//   final VoidCallback? onSuffixIconPressed;
//   final bool showCountryCodePicker;
//   final IconData? suffixIcon;
//   final Widget? suffixWidget;
//   final TextAlign textAlign;
//   final Color textColor;
//   final FormFieldValidator<String>? validator;

//   @override
//   State<CustomTextField> createState() => _CustomTextFieldState();
// }

// class _CustomTextFieldState extends State<CustomTextField> {
//   late bool _isPasswordVisible;
//   bool _showSuffixWidget = false;

//   @override
//   void initState() {
//     super.initState();
//     _isPasswordVisible = widget.isPasswordVisible;
//     widget.controller.addListener(_handleTextChanged);
//   }

//   @override
//   void dispose() {
//     widget.controller.removeListener(_handleTextChanged);
//     super.dispose();
//   }

//   void _handleTextChanged() {
//     setState(() {
//       _showSuffixWidget = widget.controller.text.length == 10;
//     });
//   }

//   void _togglePasswordVisibility() {
//     setState(() {
//       _isPasswordVisible = !_isPasswordVisible;
//     });
//   }

//   String? phoneInputValidator(PhoneNumber? phone) {
//     if (phone == null || phone.completeNumber.isEmpty) {
//       return 'Mobile Number is required';
//     }
//     try {
//       var phoneNumber = int.parse(phone.number);
//       if (phone.number.length != 10) {
//         return 'Enter a valid 10 digit mobile number';
//       }
//     } catch (e) {
//       return 'Enter a valid mobile number';
//     }
//     return null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return (widget.showCountryCodePicker)
//         ? IntlPhoneField(
//             autovalidateMode: AutovalidateMode.onUserInteraction,
//             disableLengthCheck: true,
//             decoration: InputDecoration(
//               floatingLabelBehavior: FloatingLabelBehavior.always,
//               filled: true,
//               fillColor: Colors.white,
//               hintText: widget.hintText,
//               hintStyle: TextStyle(
//                 color: widget.hintColor,
//                 fontStyle: FontStyle.italic,
//               ),
//               border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(25),
//                   borderSide: BorderSide.none),
//               enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(25),
//                   borderSide: BorderSide(color: widget.borderColor)),
//               focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(25),
//                   borderSide: BorderSide(color: widget.borderColor)),
//               contentPadding: widget.contentPadding,
//               suffixIcon: _showSuffixWidget ? widget.suffixWidget : null,
//             ),
//             initialCountryCode: 'IN',
//             onChanged: (phone) {
//               widget.controller.text = phone.number;
//             },
//             validator: phoneInputValidator,
//           )
//         : TextFormField(
//             focusNode: widget.focusnode,
//             validator: widget.validator,
//             controller: widget.controller,
//             obscureText: widget.isPassword ? !_isPasswordVisible : false,
//             keyboardType: widget.inputType,
//             enabled: widget.enabled,
//             textAlign: widget.textAlign,
//             style: TextStyle(color: widget.textColor),
//             decoration: InputDecoration(
//               filled: true,
//               fillColor: Colors.white,
//               hintText: widget.hintText,
//               hintStyle: TextStyle(
//                 color: widget.hintColor,
//                 fontStyle: FontStyle.italic,
//               ),
//               border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(25),
//                   borderSide: BorderSide.none),
//               enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(25),
//                   borderSide: BorderSide(color: widget.borderColor)),
//               focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(25),
//                   borderSide: BorderSide(color: widget.borderColor)),
//               contentPadding: widget.contentPadding,
//               suffixIcon: widget.isPassword
//                   ? IconButton(
//                       icon: Icon(
//                         _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
//                       ),
//                       onPressed: _togglePasswordVisibility,
//                     )
//                   : widget.suffixIcon != null
//                       ? IconButton(
//                           icon: Icon(widget.suffixIcon),
//                           onPressed: widget.onSuffixIconPressed,
//                         )
//                       : (_showSuffixWidget ? widget.suffixWidget : null),
//             ),
//           );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
// import 'package:intl_phone_field/phone_number.dart';

// class CustomTextField extends StatefulWidget {
//   const CustomTextField({
//     Key? key,
//     this.hintText = 'Enter text',
//     required this.controller,
//     this.inputType = TextInputType.text,
//     this.enabled = true,
//     this.textAlign = TextAlign.start,
//     this.borderColor = Colors.black,
//     this.textColor = Colors.black,
//     this.hintColor = Colors.grey,
//     this.borderRadius = 30,
//     this.contentPadding = const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
//     this.suffixIcon,
//     this.suffixWidget,
//     this.onSuffixIconPressed,
//     this.focusnode,
//     this.onSaved,
//     this.isPassword = false,
//     this.isPasswordVisible = false,
//     this.validator,
//     this.maxLines,
//     this.showCountryCodePicker = false,
//   }) : super(key: key);

//   final Function(String?)? onSaved;
//   final Color borderColor;
//   final double borderRadius;
//   final EdgeInsetsGeometry contentPadding;
//   final TextEditingController controller;
//   final bool enabled;
//   final FocusNode? focusnode;
//   final Color hintColor;
//   final String hintText;
//   final TextInputType inputType;
//   final bool isPassword;
//   final bool isPasswordVisible;
//   final int? maxLines;
//   final VoidCallback? onSuffixIconPressed;
//   final bool showCountryCodePicker;
//   final IconData? suffixIcon;
//   final Widget? suffixWidget;
//   final TextAlign textAlign;
//   final Color textColor;
//   final FormFieldValidator<String>? validator;

//   @override
//   State<CustomTextField> createState() => _CustomTextFieldState();
// }

// class _CustomTextFieldState extends State<CustomTextField> {
//   late bool _isPasswordVisible;
//   bool _showSuffixWidget = false;
//   String _formattedPhoneNumber = '';

//   @override
//   void initState() {
//     super.initState();
//     _isPasswordVisible = widget.isPasswordVisible;
//     widget.controller.addListener(_handleTextChanged);
//   }

//   @override
//   void dispose() {
//     widget.controller.removeListener(_handleTextChanged);
//     super.dispose();
//   }

//   void _handleTextChanged() {
//     setState(() {
//       _showSuffixWidget = widget.controller.text.length == 10;
//     });
//   }

//   void _togglePasswordVisibility() {
//     setState(() {
//       _isPasswordVisible = !_isPasswordVisible;
//     });
//   }

//   String? phoneInputValidator(PhoneNumber? phone) {
//     if (phone == null || phone.completeNumber.isEmpty) {
//       return 'Mobile Number is required';
//     }
//     try {
//       var phoneNumber = int.parse(phone.number);
//       if (phone.number.length != 10) {
//         return 'Enter a valid 10 digit mobile number';
//       }
//     } catch (e) {
//       return 'Enter a valid mobile number';
//     }
//     return null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return (widget.showCountryCodePicker)
//         ? IntlPhoneField(
//             autovalidateMode: AutovalidateMode.onUserInteraction,
//             disableLengthCheck: true,
//             decoration: InputDecoration(
//               floatingLabelBehavior: FloatingLabelBehavior.always,
//               filled: true,
//               fillColor: Colors.white,
//               hintText: widget.hintText,
//               hintStyle: TextStyle(
//                 color: widget.hintColor,
//                 fontStyle: FontStyle.italic,
//               ),
//               border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(25),
//                   borderSide: BorderSide.none),
//               enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(25),
//                   borderSide: BorderSide(color: widget.borderColor)),
//               focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(25),
//                   borderSide: BorderSide(color: widget.borderColor)),
//               contentPadding: widget.contentPadding,
//               suffixIcon: _showSuffixWidget ? widget.suffixWidget : null,
//             ),
//             initialCountryCode: 'IN',
//             onChanged: (phone) {
//               widget.controller.text = phone.number;
//               _formattedPhoneNumber = phone.completeNumber;
//             },
//             validator: phoneInputValidator,
//           )
//         : TextFormField(
//             focusNode: widget.focusnode,
//             validator: widget.validator,
//             controller: widget.controller,
//             obscureText: widget.isPassword ? !_isPasswordVisible : false,
//             keyboardType: widget.inputType,
//             enabled: widget.enabled,
//             textAlign: widget.textAlign,
//             style: TextStyle(color: widget.textColor),
//             decoration: InputDecoration(
//               filled: true,
//               fillColor: Colors.white,
//               hintText: widget.hintText,
//               hintStyle: TextStyle(
//                 color: widget.hintColor,
//                 fontStyle: FontStyle.italic,
//               ),
//               border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(25),
//                   borderSide: BorderSide.none),
//               enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(25),
//                   borderSide: BorderSide(color: widget.borderColor)),
//               focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(25),
//                   borderSide: BorderSide(color: widget.borderColor)),
//               contentPadding: widget.contentPadding,
//               suffixIcon: widget.isPassword
//                   ? IconButton(
//                       icon: Icon(
//                         _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
//                       ),
//                       onPressed: _togglePasswordVisibility,
//                     )
//                   : widget.suffixIcon != null
//                       ? IconButton(
//                           icon: Icon(widget.suffixIcon),
//                           onPressed: widget.onSuffixIconPressed,
//                         )
//                       : (_showSuffixWidget ? widget.suffixWidget : null),
//             ),
//           );
//   }
// }
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class CustomTextField extends StatefulWidget {
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
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
    this.suffixIcon,
    this.suffixWidget,
    this.onSuffixIconPressed,
    this.focusnode,
    this.onSaved,
    this.isPassword = false,
    this.isPasswordVisible = false,
    this.validator,
    this.maxLines,
    this.showCountryCodePicker = false,
    this.onPhoneNumberChanged,
  }) : super(key: key);

  final Function(String?)? onSaved;
  final Color borderColor;
  final double borderRadius;
  final EdgeInsetsGeometry contentPadding;
  final TextEditingController controller;
  final bool enabled;
  final FocusNode? focusnode;
  final Color hintColor;
  final String hintText;
  final TextInputType inputType;
  final bool isPassword;
  final bool isPasswordVisible;
  final int? maxLines;
  final VoidCallback? onSuffixIconPressed;
  final bool showCountryCodePicker;
  final IconData? suffixIcon;
  final Widget? suffixWidget;
  final TextAlign textAlign;
  final Color textColor;
  final FormFieldValidator<String>? validator;
  final Function(String)? onPhoneNumberChanged; // Add this line

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _isPasswordVisible;
  bool _showSuffixWidget = false;

  @override
  void initState() {
    super.initState();
    _isPasswordVisible = widget.isPasswordVisible;
    widget.controller.addListener(_handleTextChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_handleTextChanged);
    super.dispose();
  }

  void _handleTextChanged() {
    setState(() {
      _showSuffixWidget = widget.controller.text.length == 10;
    });
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  String? phoneInputValidator(PhoneNumber? phone) {
    if (phone == null || phone.completeNumber.isEmpty) {
      return 'Mobile Number is required';
    }
    if (!RegExp(r'^\+\d{1,3}\d{10}$').hasMatch(phone.completeNumber)) {
      return 'Enter a valid mobile number';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return widget.showCountryCodePicker
        ? IntlPhoneField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            disableLengthCheck: true,
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              filled: true,
              fillColor: Colors.white,
              hintText: widget.hintText,
              hintStyle: TextStyle(
                color: widget.hintColor,
                fontStyle: FontStyle.italic,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(color: widget.borderColor)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(color: widget.borderColor)),
              contentPadding: widget.contentPadding,
              suffixIcon: _showSuffixWidget ? widget.suffixWidget : null,
            ),
            initialCountryCode: 'IN',
            onChanged: (phone) {
              widget.controller.text = phone.number;
              widget.onPhoneNumberChanged?.call(phone.completeNumber); // Call the callback
            },
            validator: phoneInputValidator,
          )
        : TextFormField(
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
              fillColor: Colors.white,
              hintText: widget.hintText,
              hintStyle: TextStyle(
                color: widget.hintColor,
                fontStyle: FontStyle.italic,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(color: widget.borderColor)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(color: widget.borderColor)),
              contentPadding: widget.contentPadding,
              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: Icon(
                        _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: _togglePasswordVisibility,
                    )
                  : widget.suffixIcon != null
                      ? IconButton(
                          icon: Icon(widget.suffixIcon),
                          onPressed: widget.onSuffixIconPressed,
                        )
                      : (_showSuffixWidget ? widget.suffixWidget : null),
            ),
          );
  }
}
