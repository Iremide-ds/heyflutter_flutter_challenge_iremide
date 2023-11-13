import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:weather_app/config/constants.dart';
import 'package:weather_app/data/models/forecast.dart';

part 'weather_api.g.dart';

@RestApi(baseUrl: AppConsts.host)
abstract class WeatherRestClient {
  factory WeatherRestClient(Dio dio, {String baseUrl}) = _WeatherRestClient;

  @GET('/weather')
  Future<WeatherForecast> getForecast(@Query('lat') double latitude,
      @Query('lon') double longitude, @Query('appid') String appId);

  @GET('/forecast')
  Future<WeatherForecastMultiple> getFutureWeather(
      @Query('lat') double latitude,
      @Query('lon') double longitude,
      @Query('appid') String appId);
}
