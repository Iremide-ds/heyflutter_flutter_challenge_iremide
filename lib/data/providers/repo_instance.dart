import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/data/repository/image_api.dart';
import 'package:weather_app/data/repository/weather_api.dart';

class RepoProvider with ChangeNotifier {
  final WeatherRestClient _weatherClient;
  final ImageRestClient _imageClient;

  RepoProvider(Dio dio)
      : _weatherClient = WeatherRestClient(dio),
        _imageClient = ImageRestClient(dio);

  WeatherRestClient get weatherClient => _weatherClient;

  ImageRestClient get imageClient => _imageClient;
}
