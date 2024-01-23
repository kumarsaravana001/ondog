// ignore_for_file: constant_identifier_names

class ApiUrl {
  static const String _BASE_URL = 'https://ondgo.in/api';
  static const String _VERSION = '$_BASE_URL/api/v1';
  static const String _APIKEY =
      'e5228f82365890808f9aa2301101e76970100ff6a4cd836e9c97b0ffe7f84e06';

  static const String REGISTER = '$_VERSION/user-register.php';
  static const String LOGIN = '$_VERSION/account/register';
}
