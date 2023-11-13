import 'package:flutter/material.dart';
import 'package:weather_app/data/models/forecast.dart';

class WeatherData with ChangeNotifier {
  WeatherForecast? _weatherData;
  WeatherForecastMultiple? _futureWeatherData;
  DateTime? _lastUpdated;

  WeatherForecast? get weatherData => _weatherData;

  WeatherForecastMultiple? get futureWeatherData => _futureWeatherData;

  DateTime? get lastUpdated => _lastUpdated;

  set weatherData(WeatherForecast? value) {
    _weatherData = value;
    notifyListeners();
  }

  set futureWeatherData(WeatherForecastMultiple? value) {
    _futureWeatherData = value;
    notifyListeners();
  }

  set lastUpdated(DateTime? value) {
    _lastUpdated = value;
    notifyListeners();
  }
}
