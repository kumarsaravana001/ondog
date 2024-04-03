import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../config/config_index.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});
  Future<void> _checkInternetAndLaunchURL(String url) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } else {
      _launchURL(url);
    }
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
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
                    child: Text(AppLocalisation.contact,
                        style: GoogleFonts.baiJamjuree(fontSize: 28.sp))),
                Padding(
                  padding: EdgeInsets.only(left: 12.sp, top: 15.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppLocalisation.checkourwebsit,
                          style: AppTextStyle.headingint(fontSize: 20.sp)),
                      _buildSocialText(
                        text: AppLocalisation.websitlink,
                        url: 'https://www.ondgo.live/',
                      ),
                      SizedBox(height: 2.5.h),
                      Text(AppLocalisation.reachouttouson,
                          style: AppTextStyle.headingint(fontSize: 20.sp)),
                      _buildSocialText(
                        text: AppLocalisation.infoondgolive,
                        url: 'https://www.ondgo.live/',
                      ),
                      SizedBox(height: 5.5.h),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildSocialIcon(
                      icon: Image.asset("assets/images/youtube_icon.png",
                          height: 50, width: 50),
                      url: 'https://www.youtube.com/@ondgolive',
                    ),
                    _buildSocialIcon(
                      icon: Image.asset("assets/images/instagram_icon.png",
                          height: 50, width: 50),
                      url: 'https://www.instagram.com/ondgo.app/',
                    ),
                    _buildSocialIcon(
                      icon: Image.asset("assets/images/facebook_icon.png",
                          height: 50, width: 50),
                      url: 'https://www.facebook.com/ondgolive/',
                    ),
                    _buildSocialIcon(
                      icon: Image.asset("assets/images/twitter_icon.png",
                          height: 40, width: 40),
                      url: 'https://twitter.com/ondgolive',
                    ),
                    _buildSocialIcon(
                      icon: Image.asset("assets/images/linkedin_icon.png",
                          height: 50, width: 50),
                      url: 'https://www.linkedin.com/company/ondgolive/',
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              top: 0,
              right: 30,
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
    );
  }

  Widget _buildSocialIcon({
    // required String text,
    required String url,
    required Widget icon,
  }) {
    return GestureDetector(
      onTap: () {
        _launchURL(url);
      },
      child: icon,
    );
  }

  Widget _buildSocialText({required String text, required String url}) {
    return GestureDetector(
      onTap: () {
        _launchURL(url);
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 5.sp),
        child: Text(
          text,
          style: AppTextStyle.headingint(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
