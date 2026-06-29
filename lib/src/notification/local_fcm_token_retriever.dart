import 'package:shared_preferences/shared_preferences.dart';

class LocalFcmTokenRetriever {
  static const _itemKey = 'qf_biker_fcm_key';

  Future<String?> get() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_itemKey);
  }

  Future<void> save(String? data) async {
    final prefs = await SharedPreferences.getInstance();
    if (data == null) {
      await prefs.remove(_itemKey);
    } else {
      await prefs.setString(_itemKey, data);
    }
  }

  Future<void> delete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_itemKey);
  }
}
