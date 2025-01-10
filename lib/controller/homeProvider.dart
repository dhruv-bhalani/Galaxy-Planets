import 'package:flutter/foundation.dart';
import 'package:pr_6_space_app/helper/helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeProvider extends ChangeNotifier {
  static const String likedPlanetsKey = 'likedPlanets';
  List<String> likedPlanets = [];
  bool isDarkTheme = false;

  HomeProvider() {
    _loadLikedPlanets();
  }

  void _loadLikedPlanets() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    likedPlanets = prefs.getStringList(likedPlanetsKey) ?? [];
    notifyListeners();
  }

  Future<void> addLikedPlanet(String name) async {
    if (!likedPlanets.contains(name)) {
      likedPlanets.add(name);
      await _updateLikedPlanets();
      notifyListeners();
    }
  }

  Future<void> removeLikedPlanet(String name) async {
    if (likedPlanets.contains(name)) {
      likedPlanets.remove(name);
      await _updateLikedPlanets();
      notifyListeners();
    }
  }

  Future<void> _updateLikedPlanets() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(likedPlanetsKey, likedPlanets);
  }

  void changeTheme(bool val) {
    isDarkTheme = val;
    ShrHelper.shrHelper.themeset(val);
    notifyListeners();
  }

  Future<void> checkTheme() async {
    bool? val = await ShrHelper.shrHelper.themeget();
    isDarkTheme = val!;
    notifyListeners();
  }
}
