import 'package:flutter/material.dart';

class CurrentWeatherDisplay {
  final String _icon;
  final String _description;
  final double temperature;

  CurrentWeatherDisplay(
      {required String icon,
      required String description,
      required this.temperature})
      : _icon = icon,
        _description = description;

  String get icon {
    return 'https://openweathermap.org/img/wn/$_icon@2x.png';
  }

  String get description {
    return _description.replaceFirst(_description.characters.first,
        _description.characters.first.toUpperCase());
  }
}
