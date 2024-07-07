import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const _tokenKey = 'auth_token';

  // Store the authentication token
  static Future<void> storeAuthToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  // Retrieve the authentication token
  static Future<String?> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // Clear the authentication token (logout)
  static Future<void> clearAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }
}
