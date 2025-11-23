import 'package:shared_preferences/shared_preferences.dart';

class AuthLocal {
  // SIMPAN DATA SAAT REGISTRASI
  static Future<bool> register({
    required String nama,
    required String email,
    required String password,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("nama", nama);
    await prefs.setString("email", email);
    await prefs.setString("password", password);

    return true;
  }

  // LOGIN
  static Future<bool> login({
    required String email,
    required String password,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    String? savedEmail = prefs.getString("email");
    String? savedPassword = prefs.getString("password");

    if (email == savedEmail && password == savedPassword) {
      await prefs.setBool("isLogin", true);
      return true;
    }
    return false;
  }

  // LOGOUT
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isLogin", false);
  }

  // CEK STATUS LOGIN
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isLogin") ?? false;
  }
}
