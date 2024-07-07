import 'package:hive_flutter/hive_flutter.dart';

class Utils {
  static Future<String?> getUserId() async {
    var box = Hive.box('sessionBox');
    return box.get('userId');
  }
}

class ApiUrl {
  static const String apiKey =
      'e5228f82365890808f9aa2301101e76970100ff6a4cd836e9c97b0ffe7f84e06';
}

class ApiBase {
  static String baseUrl = 'https://admin.ondgo.in';
  static String version = '$baseUrl/api';

  static String login = '$version/user-login.php';
  static String register = '$version/user-register.php';
  static String homescreenBanner = '$version/user-home-screen-banner.php';
  static String popularPicks = '$version/user-home-popular-pickup.php';
  static String spotlight = '$version/user-home-spotlight.php';
  static String categoryWiseShow = '$version/user-category-wise-show.php';
  static String categoryWiseList = '$version/user-home-category-list.php';
  static String categoryWiseListSearch = '$version/.php'; //check
  static String userShowDetails = '$version/user-show-details.php';
  static String episodeDetails = '$version/user-episode-details.php';
  static String quizDetails = '$version/user-quiz-details.php';
  static String userVideoDetails = '$version/user-video-details.php';
  static String userReelsDetails = '$version/user-reels.php';
  static String shareyoutThoughtsVideo = '$version/user-shareyourthoughts.php';
  static String shareyoutThoughtsVideoDetails =
      '$version/user-shareyourthoughts-details.php';
  static String ratingSubmit = '$version/user-rating.php';
  static String ratingDetails = '$version/user-rating.php';
  static String favouriteSubmit = '$version/user-shareyourthoughts-details.php';
  static String favouriteDetails = '$version/user-favorite-details.php';
  static String feedBack = '$version/user-feedback.php';
  static String rewards = '$version/user-rewards.php';
  static String purchase = '$version/user-purchase.php';
  static String events = '$version/user-event.php';
}
