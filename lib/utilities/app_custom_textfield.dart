// import 'package:country_code_picker/country_code_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:ondgo_flutter/config/config_index.dart';
// import 'package:ondgo_flutter/utilities/app_textfie.dart';

// class CustomMobileField extends StatelessWidget {
//   final TextEditingController mobileController;
//   final FocusNode mobilenumberFocusNode;

//   const CustomMobileField({
//     Key? key,
//     required this.mobileController,
//     required this.mobilenumberFocusNode,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Container(
//           decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(20),
//               border: Border.all(color: AppColors.white)),
//           child: CountryCodePicker(
//             padding: EdgeInsets.zero,
//             initialSelection: 'IN',
//             favorite: const ['+91', 'IN'],
//             showCountryOnly: false,
//             showOnlyCountryWhenClosed: false,
//             alignLeft: false,
//             onChanged: (CountryCode countryCode) {},
//           ),
//         ),
//         Expanded(
//           child: CustomTextField(
//             controller: mobileController,
//             focusnode: mobilenumberFocusNode,
//             hintText: "Mobile Number",
//             borderColor: AppColors.white,
//             textColor: AppColors.black,
//             inputType: TextInputType.number,
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Mobile Number is required';
//               }
//               String pattern = r'^[0-9]{10}$';
//               RegExp regex = RegExp(pattern);
//               if (!regex.hasMatch(value)) {
//                 return 'Enter a valid 10 digit mobile number';
//               }
//               return null;
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
