import 'dart:io';
import 'package:path/path.dart' as path;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ondgo_flutter/config/config_index.dart';
import 'package:path_provider/path_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

Future<void> logout() async {
  var box = Hive.box('sessionBox');
  await box.delete('userId');
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String imagePath;
  File? image;

  @override
  void initState() {
    super.initState();
    _loadImagePath();
  }

  Future<void> _loadImagePath() async {
    var box = Hive.box('userBox');
    imagePath = box.get('profileImagePath', defaultValue: '');
    setState(() {});
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
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
                      SvgPicture.asset(
                        width: MediaQuery.of(context).size.width,
                        IconAssets.profilebg,
                      ),
                      Positioned(
                          top: 0,
                          right: 30,
                          child: SvgPicture.asset(IconAssets.badgecloseblack)),
                      Positioned(
                          bottom: -15.sp,
                          left: MediaQuery.of(context).size.width * 0.5 - 30,
                          child: SvgPicture.asset(
                              IconAssets.proflestandalonelevel)),
                      Positioned(
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 35.sp),
                            child: Column(
                              children: [
                                Center(
                                  child: Stack(
                                    alignment: Alignment.bottomRight,
                                    children: <Widget>[
                                      CircleAvatar(
                                        radius:
                                            80, // Adjust the radius as needed
                                        backgroundColor: Colors.grey.shade300,
                                        backgroundImage: image != null
                                            ? FileImage(image!)
                                            : null,
                                        child: image == null
                                            ? Icon(Icons.person,
                                                size: 80) // Placeholder icon
                                            : null,
                                      ),
                                      FloatingActionButton(
                                        mini: true, // Makes the button smaller
                                        onPressed: _pickImage,
                                        child: Icon(Icons.edit),
                                      ),
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
                                    // Extracting data from snapshot
                                    String firstName =
                                        snapshot.data?['firstName'] ?? 'User';
                                    String email = snapshot.data?['email'] ??
                                        'email@example.com';
                                    return Column(
                                      children: [
                                        // Your existing Stack widget...
                                        Padding(
                                          padding: EdgeInsets.only(top: 16.sp),
                                          child: Text(
                                            firstName, // Displaying the first name
                                            style: AppTestStyle.headingBai(
                                                color: AppColors.white,
                                                fontSize: 24.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 10.sp),
                                          child: Text(
                                            email, // Displaying the email
                                            style: AppTestStyle.headingint(
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
                top: MediaQuery.of(context).size.height * 0.5 - 35.sp,
                left: -10,
                right: -10,
                child: SvgPicture.asset(IconAssets.profilelevels,
                    // ignore: deprecated_member_use
                    color: AppColors.black),
              ),
              Positioned(
                top: 10,
                left: 20,
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(Icons.arrow_back_outlined,
                          color: AppColors.white, size: 30),
                    )
                  ],
                ),
              ),
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
      child: Text(text, style: AppTestStyle.headingBai(fontSize: 22.sp)),
    ),
  );
}
