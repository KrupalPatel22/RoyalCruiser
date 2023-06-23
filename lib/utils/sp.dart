import 'package:shared_preferences/shared_preferences.dart';

class Sp {
  setUserFirstTime() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool('isFirstTime', false);
  }

  Future<bool> getIsUserFirstTime() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool('isFirstTime')??true;
  }
}
