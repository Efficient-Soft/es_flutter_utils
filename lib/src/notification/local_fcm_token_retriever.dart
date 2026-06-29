import 'package:shared_preferences/shared_preferences.dart';

class LocalFcmTokenRetriever {
  static String itemKey = 'fcm_token_key';

  Future<String?> get() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(itemKey);
  }

  Future<void> save(String? data) async {
    final prefs = await SharedPreferences.getInstance();
    if (data == null) {
      await prefs.remove(itemKey);
    } else {
      await prefs.setString(itemKey, data);
    }
  }

  Future<void> delete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(itemKey);
  }
}
