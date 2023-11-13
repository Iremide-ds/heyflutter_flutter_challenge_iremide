import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/config/constants.dart';
import 'package:weather_app/data/models/current_weather_display.dart';
import 'package:weather_app/data/models/forecast.dart';
import 'package:weather_app/data/providers/persistence_provider.dart';
import 'package:weather_app/data/providers/repo_instance.dart';
import 'package:weather_app/data/providers/weather_data.dart';
import 'package:weather_app/data/repository/weather_api.dart';

class WeatherService {
  final WeatherRestClient _client;
  final SharedPreferences _prefs;
  final BuildContext context;
  final Logger _logger;

  WeatherService(this.context)
      : _client = context.read<RepoProvider>().weatherClient,
        _prefs = context.read<PersistenceProvider>().prefs,
        _logger = Logger();

  Future<void> getForecast(double lat, double lon) async {
    try {
      final response =
          await _client.getForecast(lat, lon, AppConsts.weatherApiId);

      await Future.wait([
        _prefs.setString(
            AppConsts.forecastLocalData, jsonEncode(response.toJson())),
        _prefs.setString(
            AppConsts.forecastUpdateLocalData, DateTime.now().toIso8601String())
      ]);

      // ignore: use_build_context_synchronously
      context.read<WeatherData>().weatherData = response;
    } catch (e, t) {
      if (kDebugMode) {
        _logger.e(e);
        _logger.t(t);
      }
    }
  }

  void initData() {
    try {
      final existingData = _prefs.getString(AppConsts.forecastLocalData);

      if (existingData != null) {
        context.read<WeatherData>().weatherData =
            WeatherForecast.fromJson(jsonDecode(existingData));
        context.read<WeatherData>().futureWeatherData =
            WeatherForecastMultiple.fromJson(jsonDecode(
                _prefs.getString(AppConsts.futureForecastLocalData) ?? '{}'));
        context.read<WeatherData>().lastUpdated = DateTime.tryParse(
            _prefs.getString(AppConsts.forecastUpdateLocalData) ?? '');
      }
    } catch (e, t) {
      if (kDebugMode) {
        _logger.e(e);
        _logger.t(t);
      }
    }
  }

  CurrentWeatherDisplay getCurrentWeather(WeatherForecast weatherForecast) {
    final CurrentWeatherDisplay result = CurrentWeatherDisplay(
        description: weatherForecast.weather.first.main.toLowerCase(),
        icon: weatherForecast.weather.first.icon,
        temperature: weatherForecast.main.temp);

    return result;
  }

  Future<void> getFutureWeather(double lat, double lon) async {
    try {
      final response =
          await _client.getFutureWeather(lat, lon, AppConsts.weatherApiId);

      await _prefs.setString(
          AppConsts.futureForecastLocalData, jsonEncode(response.toJson()));

      // ignore: use_build_context_synchronously
      context.read<WeatherData>().futureWeatherData = response;
    } catch (e, t) {
      if (kDebugMode) {
        _logger.e(e);
        _logger.t(t);
      }
    }
  }
}
