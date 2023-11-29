import 'package:shared_preferences/shared_preferences.dart';

class Cookies {
  load({String key = ''}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(key) ?? "";
  }

  save({String key = '', String value = ''}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }
}
