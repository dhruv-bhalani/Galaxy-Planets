import 'package:flutter/material.dart';
import '../model/data_model.dart';

class PlanetProvider extends ChangeNotifier {
  List<Planets> jsonData = [];

  void setData(List<dynamic> data) {
    jsonData = data.map((e) => Planets.fromJson(e)).toList();
    notifyListeners();
  }
}