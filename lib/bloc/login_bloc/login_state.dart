import 'package:shared_preferences/shared_preferences.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure(this.error);
}

Future<bool> isLoggedIn() async {
  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('login_token') ?? '';
  return token.isNotEmpty;
}

Future<void> saveLoginState(String token) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(
      'login_token', token); // Use a key like 'login_token' to store the token
}
