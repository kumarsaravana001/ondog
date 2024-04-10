import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ondgo_flutter/bloc/profile_bloc/feedback_bloc/feedback_event.dart';
import '../../../bloc/profile_bloc/feedback_bloc/feedback_bloc.dart';
import '../../../bloc/profile_bloc/feedback_bloc/feedback_state.dart';
import '../../../config/config_index.dart';
import '../../../utilities/index.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FeedbackBloc(),
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          resizeToAvoidBottomInset: false,
          body: BlocListener<FeedbackBloc, FeedbackState>(
            listener: (context, state) {
              if (state is FeedbackSuccess) {
                // Display Snackbar on success
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Comment submitted successfully")),
                );
                // Clear comment box on success
                commentController.clear();
              } else if (state is FeedbackError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            child: Stack(
              children: [
                Positioned(
                  bottom: -125,
                  left: -10,
                  right: 30,
                  child: SvgPicture.asset(IconAssets.bottombgdiamond),
                ),
                Column(
                  children: [
                    SvgPicture.asset(
                        width: MediaQuery.of(context).size.width,
                        IconAssets.profilescreenbgblack),
                    Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.only(top: 15.sp),
                          child: Text(
                            AppLocalisation.feedback,
                            style: GoogleFonts.baiJamjuree(
                              fontSize: 24.sp,
                              color: AppColors.black,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        )),
                    Padding(
                      padding: EdgeInsets.fromLTRB(15.sp, 10.sp, 15.sp, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // CustomTextField(
                          //   controller: nameController,
                          //   hintText: "Enter Name",
                          // ),
                          // SizedBox(height: 1.5.h),
                          // CustomTextField(
                          //   controller: emailController,
                          //   hintText: "Enter Email",
                          // ),
                          SizedBox(height: 1.5.h),
                          Container(
                            height: 50.sp,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: TextField(
                              controller: commentController,
                              decoration: InputDecoration(
                                  hintText: 'Comments',
                                  hintStyle: TextStyle(
                                    fontSize: 20.sp,
                                    color: Colors.grey,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 15)),
                              maxLines: null,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.sp, vertical: 20.sp),
                            child: Row(
                              children: [
                                Text(
                                  "Rating",
                                  style: AppTextStyle.headingint(
                                      fontSize: 20.sp, color: Colors.grey),
                                ),
                                SizedBox(width: 2.w),
                                RatingBar.builder(
                                  initialRating: 3,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemPadding:
                                      EdgeInsets.symmetric(horizontal: 3.sp),
                                  itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: Colors.amber),
                                  onRatingUpdate: (rating) {},
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.only(top: 20.sp),
                              child: CustomElevatedButton(
                                fontsize: 16.sp,
                                fontWeight: FontWeight.w800,
                                labelcolor: AppColors.black,
                                backgroundcolor: AppColors.white,
                                bordercolor: AppColors.black,
                                text: 'Submit',
                                onPressed: () {
                                  final feedbackBloc =
                                      BlocProvider.of<FeedbackBloc>(context);
                                  feedbackBloc.add(SubmitFeedback(
                                      comment: commentController.text));
                                  commentController.clear();
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 0,
                  right: 22.sp,
                  child: Row(
                    children: [SvgPicture.asset(IconAssets.badgeopen)],
                  ),
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
      ),
    );
  }
}
