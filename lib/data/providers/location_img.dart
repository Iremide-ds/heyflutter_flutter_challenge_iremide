import 'package:flutter/material.dart';

class LocationImageProvider with ChangeNotifier {
  String? _locationImage = '';

  String get locationImage => _locationImage.toString();

  set locationImage(String? value) {
    _locationImage = value;
    notifyListeners();
  }
}
