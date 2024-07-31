import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  SharedPreferencesManager(this.prefs);
  final SharedPreferences prefs;

  Future<void> storeString(String key, String value) async =>
      prefs.setString(key, value);
  Future<void> storeBool({required String key, required bool value}) async =>
      prefs.setBool(key, value);

  Future<String?> retrieveString(String key) async => prefs.getString(key);
  Future<bool> retrieveBool(String key) async => prefs.getBool(key) ?? false;

  Future<void> remove(String key) async => prefs.remove(key);

  Future<void> removeAll() async => prefs.clear();
}
