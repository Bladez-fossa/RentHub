import 'package:shared_preferences/shared_preferences.dart';

class Shared {
  static String loginSharedPref = 'LOGGENINKEY';
  //save data
  static Future<bool> saveLoginSharedPref(islogin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(loginSharedPref, islogin);
  }

//fetch data
  static Future getUserSharedPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(loginSharedPref);
  }
}
