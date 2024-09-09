import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  SharedPreferencesManager._internal();
  static final SharedPreferencesManager shared =
      SharedPreferencesManager._internal();
  factory SharedPreferencesManager() => shared;

  setPrefBool(key, val) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool(key, val);
  }

   getPrefBool(key) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getBool(key) ?? true;
  }
  setPrefString(key, value) async {
    print('my vals: $value');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  getPrefString(key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  removePref(key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }

  clearPrefString() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
