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

  ////
  static const String baseUrl = 'https://ondgo.in/api/';
  static const String usershowdetails = 'user-show-details.php';
}
