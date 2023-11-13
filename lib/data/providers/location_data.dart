import 'package:flutter/material.dart';

class CountryData with ChangeNotifier {
  String? _country;

  String? get country => _country;

  set country(String? value) {
    _country = value;
    notifyListeners();
  }
}
