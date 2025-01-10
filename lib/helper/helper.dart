import 'package:shared_preferences/shared_preferences.dart';

class ShrHelper {
  static ShrHelper shrHelper = ShrHelper();

  void themeset(bool val) async {
    SharedPreferences shr = await SharedPreferences.getInstance();
    shr.setBool("themes", val);
  }

  Future<bool?> themeget() async {
    SharedPreferences shr = await SharedPreferences.getInstance();
    bool? val = shr.getBool("themes");
    return val;
  }
}
