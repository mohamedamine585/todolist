import 'package:shared_preferences/shared_preferences.dart';

class Sharedprefs {
  void ConfirmuserAction(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<String?> ProoveUserAuthentication(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
}
