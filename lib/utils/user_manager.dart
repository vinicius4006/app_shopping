import 'package:shared_preferences/shared_preferences.dart';

class UserManager {
  static void writeAuth(
      String token, String userId, String email, String expiryDate) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setString('userId', userId);
    await prefs.setString('email', email);
    await prefs.setString('expiryDate', expiryDate);
  }

  static Future<Map<String, dynamic>> get isAuth async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final data = {
      'token': prefs.getString('token') ?? '',
      'userId': prefs.getString('userId') ?? '',
      'email': prefs.getString('email') ?? '',
      'expiryDate': prefs.getString('expiryDate') ?? ''
    };
    return data;
  }

  static Future<void> removeAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
