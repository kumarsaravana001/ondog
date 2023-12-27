import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
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
                        style: AppTestStyle.headingBai(fontSize: 28.sp))),
                Column(
                  // crossAxisAlignment: CrsossAxisAlignment.start,
                  children: [
                    Text(AppLocalisation.checkourwebsit,
                        style: AppTestStyle.headingint(fontSize: 20.sp)),
                    _buildSocialText(
                      text: AppLocalisation.websitlink,
                      url: 'https://www.ondgo.live/',
                    ),
                    SizedBox(height: 2.5.h),
                    Text(AppLocalisation.reachouttouson,
                        style: AppTestStyle.headingint(fontSize: 20.sp)),
                    Text(AppLocalisation.infoondgolive,
                        style: AppTestStyle.headingint(
                            fontSize: 20.sp, fontWeight: FontWeight.bold)),
                    SizedBox(height: 5.5.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildSocialIcon(
                          icon: IconAssets.youtubeicon,
                          url: 'https://www.youtube.com/@ondgolive',
                        ),
                        _buildSocialIcon(
                          icon: IconAssets.instagramicon,
                          url: 'https://www.instagram.com/ondgo.app/',
                        ),
                        _buildSocialIcon(
                          icon: IconAssets.facebookicon,
                          url: 'https://www.facebook.com/ondgolive/',
                        ),
                        _buildSocialIcon(
                          icon: IconAssets.twittericon,
                          url: 'https://twitter.com/ondgolive',
                        ),
                        _buildSocialIcon(
                          icon: IconAssets.linkedinicon,
                          url: 'https://www.linkedin.com/company/ondgolive/',
                        ),
                      ],
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
    required String icon,
  }) {
    return GestureDetector(
      onTap: () {
        _launchURL(url);
      },
      child: SvgPicture.asset(icon),
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
          style: AppTestStyle.headingint(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
