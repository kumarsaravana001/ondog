// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ondgo_flutter/config/config_index.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? image;
  String firstName = '';
  String email = '';

  @override
  void initState() {
    super.initState();
    _loadImagePath();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    var box = Hive.box('userBox');
    String storedFirstName =
        box.get('firstName', defaultValue: 'User') as String;
    String storedEmail =
        box.get('email', defaultValue: 'email@example.com') as String;

    setState(() {
      firstName = storedFirstName;
      email = storedEmail;
    });
  }

  Future<void> _loadImagePath() async {
    var box = Hive.box('userBox');
    String? imagePath = box.get('profileImagePath');
    if (imagePath != null) {
      setState(() {
        image = File(imagePath);
      });
    }
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      Box userBox = await Hive.openBox('userBox');

      await userBox.put('profileImagePath', pickedFile.path);
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  Future<Map<String, dynamic>> getUserData() async {
    var box = Hive.box('userBox');
    String firstName = box.get('firstName', defaultValue: 'User');
    String email = box.get('email', defaultValue: 'email@example.com');
    return {"firstName": firstName, "email": email};
  }

  Future<void> logout() async {
    var box = Hive.box('sessionBox');
    await box.delete('userId');
    GoRouter.of(context).go('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      // ClipPath(
                      //   clipper: TriangularClipper(),
                      //   child: Container(
                      //     height: 54.h,
                      //     color: Colors.black,
                      //   ),
                      // ),
                      SvgPicture.asset(
                        width: MediaQuery.of(context).size.width,
                        IconAssets.profilebg,
                      ),
                      // Positioned(
                      //     top: 0,
                      //     right: 30,
                      //     child: SvgPicture.asset(IconAssets.badgecloseblack)),
                      Positioned(
                        top: 0,
                        right: 22.sp,
                        child: Row(
                          children: [SvgPicture.asset(IconAssets.badgeopen)],
                        ),
                      ),
                      Positioned(
                          bottom: -15.sp,
                          left: MediaQuery.of(context).size.width * 0.5 - 30,
                          child: SvgPicture.asset(
                              IconAssets.proflestandalonelevel)),
                      Positioned(
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 30.sp),
                            child: Column(
                              children: [
                                Center(
                                  child: Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            width: 50.w,
                                            height: 50.w,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.grey.shade300,
                                              image: image != null
                                                  ? DecorationImage(
                                                      image: FileImage(image!),
                                                      fit: BoxFit.cover,
                                                    )
                                                  : null,
                                            ),
                                            child: image == null
                                                ? const Icon(Icons.person,
                                                    size: 80)
                                                : null,
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            left: 0,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 4),
                                                child: InkWell(
                                                  onTap: _pickImage,
                                                  child: const Text(
                                                    'Edit Profile',
                                                    style: TextStyle(
                                                      color: Colors
                                                          .white, // Text color
                                                      fontSize:
                                                          12, // Adjust font size
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      // Container(
                                      //   width: 50.w,
                                      //   height: 50.w,
                                      //   decoration: BoxDecoration(
                                      //     borderRadius:
                                      //         BorderRadius.circular(20),
                                      //     color: Colors.grey.shade300,
                                      //     image: image != null
                                      //         ? DecorationImage(
                                      //             image: FileImage(image!),
                                      //             fit: BoxFit.cover,
                                      //           )
                                      //         : null,
                                      //   ),
                                      //   child: image == null
                                      //       ? const Icon(Icons.person, size: 80)
                                      //       : null,
                                      // ),

                                      // CircleAvatar(
                                      //   radius: 70,
                                      //   backgroundColor: Colors.grey.shade300,
                                      //   backgroundImage: image != null
                                      //       ? FileImage(image!)
                                      //       : null,
                                      //   child: image == null
                                      //       ? const Icon(Icons.person, size: 80)
                                      //       : null,
                                      // ),
                                      // FloatingActionButton(
                                      //   mini: true, // Makes the button smaller
                                      //   onPressed: _pickImage,
                                      //   child: const Icon(Icons.edit),
                                      // ),
                                    ],
                                  ),
                                ),
                                FutureBuilder<Map<String, dynamic>>(
                                  future: getUserData(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    }

                                    return Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(top: 16.sp),
                                          child: Text(
                                            firstName,
                                            style: GoogleFonts.baiJamjuree(
                                                color: AppColors.white,
                                                fontSize: 24.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 10.sp),
                                          child: Text(
                                            email, // Displaying the email
                                            style: AppTextStyle.headingint(
                                                color: AppColors.white,
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                        // Your remaining widgets...
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32.sp),
                  buildClickableText(AppLocalisation.yourplaylist, () {
                    context.push("/playlist");
                  }),
                  buildClickableText(AppLocalisation.events, () {
                    context.push("/events");
                  }),
                  buildClickableText(AppLocalisation.purchase, () {
                    context.push("/purchase");
                  }),
                  buildClickableText(AppLocalisation.rewards, () {
                    context.push("/rewards");
                  }),
                  buildClickableText(AppLocalisation.language, () {
                    context.push("/language");
                  }),
                  buildClickableText(AppLocalisation.help, () {
                    context.push("/help");
                  }),
                  buildClickableText(AppLocalisation.feedback, () {
                    context.push("/feedback");
                  }),
                  buildClickableText(AppLocalisation.contact, () {
                    context.push("/contact");
                  }),
                  buildClickableText(AppLocalisation.logout, () {
                    logout();
                    context.push("/splash2");
                  }),
                  SizedBox(height: 8.h),
                ],
              ),
              Positioned(
                top: 76.sp,
                left: -10.sp,
                right: -10.sp,
                child: SvgPicture.asset(IconAssets.profilelevels,
                    color: AppColors.black),
              ),
              // Positioned(
              //   top: 10,
              //   left: 20,
              //   child: Row(
              //     children: [
              //       InkWell(
              //         onTap: () {
              //           Navigator.of(context).pop();
              //         },
              //         child: const Icon(Icons.arrow_back_outlined,
              //             color: AppColors.white, size: 30),
              //       )
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildClickableText(String text, VoidCallback onPressed) {
  return GestureDetector(
    onTap: onPressed,
    child: Padding(
      padding: EdgeInsets.only(left: 25.sp, bottom: 10.sp),
      child: Text(text,
          style: GoogleFonts.baiJamjuree(
            fontSize: 22.sp,
            fontWeight: FontWeight.w800,
          )),
    ),
  );
}
