
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:ondgo_flutter/config/config_index.dart';

// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});

//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   File? image;
//   String firstName = '';
//   String email = '';

//   @override
//   void initState() {
//     super.initState();
//     _loadImagePath();
//     _loadUserData();
//   }

//   Future<void> _loadUserData() async {
//     var box = Hive.box('userBox');
//     String storedFirstName =
//         box.get('firstName', defaultValue: 'User') as String;
//     String storedEmail =
//         box.get('email', defaultValue: 'email@example.com') as String;

//     setState(() {
//       firstName = storedFirstName;
//       email = storedEmail;
//     });
//   }

//   Future<void> _loadImagePath() async {
//     var box = Hive.box('userBox');
//     String? imagePath = box.get('profileImagePath');
//     if (imagePath != null) {
//       setState(() {
//         image = File(imagePath);
//       });
//     }
//   }

//   Future<void> _pickImage() async {
//     final pickedFile =
//         await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       Box userBox = await Hive.openBox('userBox');

//       await userBox.put('profileImagePath', pickedFile.path);
//       setState(() {
//         image = File(pickedFile.path);
//       });
//     }
//   }

//   Future<void> logout() async {
//     var box = Hive.box('sessionBox');
//     await box.delete('userId');
//     GoRouter.of(context).go('/login');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: SafeArea(
//           child: Stack(
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Stack(
//                     children: [
//                       // ClipPath(
//                       //   clipper: TriangularClipper(),
//                       //   child: Container(
//                       //     height: 54.h,
//                       //     color: Colors.black,
//                       //   ),
//                       // ),
//                       SvgPicture.asset(
//                         width: MediaQuery.of(context).size.width,
//                         IconAssets.profilebg,
//                       ),
//                       // Positioned(
//                       //     top: 0,
//                       //     right: 30,
//                       //     child: SvgPicture.asset(IconAssets.badgecloseblack)),
//                       Positioned(
//                         top: 0,
//                         right: 22.sp,
//                         child: Row(
//                           children: [SvgPicture.asset(IconAssets.badgeopen)],
//                         ),
//                       ),
//                       Positioned(
//                           bottom: -15.sp,
//                           left: MediaQuery.of(context).size.width * 0.5 - 30,
//                           child: SvgPicture.asset(
//                               IconAssets.proflestandalonelevel)),
//                       Positioned(
//                         child: Center(
//                           child: Padding(
//                             padding: EdgeInsets.only(top: 30.sp),
//                             child: Column(
//                               children: [
//                                 Center(
//                                   child: Stack(
//                                     alignment: Alignment.bottomRight,
//                                     children: [
//                                       Stack(
//                                         alignment: Alignment.center,
//                                         children: [
//                                           Container(
//                                             width: 50.w,
//                                             height: 50.w,
//                                             decoration: BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(20),
//                                               color: Colors.grey.shade300,
//                                               image: image != null
//                                                   ? DecorationImage(
//                                                       image: FileImage(image!),
//                                                       fit: BoxFit.cover,
//                                                     )
//                                                   : null,
//                                             ),
//                                             child: image == null
//                                                 ? const Icon(Icons.person,
//                                                     size: 80)
//                                                 : null,
//                                           ),
//                                           Positioned(
//                                             bottom: 0,
//                                             left: 0,
//                                             child: Padding(
//                                               padding:
//                                                   const EdgeInsets.all(8.0),
//                                               child: Container(
//                                                 decoration: BoxDecoration(
//                                                   color: Colors.black,
//                                                   borderRadius:
//                                                       BorderRadius.circular(20),
//                                                 ),
//                                                 padding:
//                                                     const EdgeInsets.symmetric(
//                                                         horizontal: 8,
//                                                         vertical: 4),
//                                                 child: InkWell(
//                                                   onTap: _pickImage,
//                                                   child: const Text(
//                                                     'Edit Profile',
//                                                     style: TextStyle(
//                                                       color: Colors
//                                                           .white, // Text color
//                                                       fontSize:
//                                                           12, // Adjust font size
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.only(top: 16.sp),
//                                   child: Text(
//                                     firstName,
//                                     style: GoogleFonts.baiJamjuree(
//                                         color: AppColors.white,
//                                         fontSize: 24.sp,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.only(top: 10.sp),
//                                   child: Text(
//                                     email, // Displaying the email
//                                     style: AppTextStyle.headingint(
//                                         color: AppColors.white,
//                                         fontSize: 18.sp,
//                                         fontWeight: FontWeight.normal),
//                                   ),
//                                 ),
//                                 SizedBox(height: 32.sp),
//                                 buildClickableText(AppLocalisation.yourplaylist,
//                                     () {
//                                   context.push("/playlist");
//                                 }),
//                                 buildClickableText(AppLocalisation.events, () {
//                                   context.push("/events");
//                                 }),
//                                 buildClickableText(AppLocalisation.purchase,
//                                     () {
//                                   context.push("/purchase");
//                                 }),
//                                 buildClickableText(AppLocalisation.logout, () {
//                                   logout();
//                                 }),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildClickableText(String text, Function onTap) {
//     return GestureDetector(
//       onTap: () {
//         onTap();
//       },
//       child: Padding(
//         padding: EdgeInsets.symmetric(vertical: 10.sp),
//         child: Text(
//           text,
//           style: AppTextStyle.headingint(
//               color: AppColors.white,
//               fontSize: 16.sp,
//               fontWeight: FontWeight.normal),
//         ),
//       ),
//     );
//   }
// }
