import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences sharedPreferences;

Future<SharedPreferences> getPrefs() async {
  if (sharedPreferences == null)
    sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences;
}
