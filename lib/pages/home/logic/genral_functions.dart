import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/config/constants.dart';
import 'package:weather_app/data/providers/location_data.dart';
import 'package:weather_app/data/providers/persistence_provider.dart';
import 'package:weather_app/data/services/image_service.dart';
import 'package:weather_app/data/services/location_service.dart';
import 'package:weather_app/data/services/weather_service.dart';

class GeneralFunctions {
  static bool isFirstTime(BuildContext context) {
    final response = context
            .read<PersistenceProvider>()
            .prefs
            .getBool(AppConsts.firstTime) ??
        true;

    return response;
  }

  static Future<void> setFirstTime(BuildContext context) async {
    await context
        .read<PersistenceProvider>()
        .prefs
        .setBool(AppConsts.firstTime, false);
  }

  static void initData(
      LocationService locationService,
      WeatherService weatherService,
      ImageService imgService,
      BuildContext context) {
    weatherService.initData();
    imgService.initData();
    context.read<CountryData>().country = context
        .read<PersistenceProvider>()
        .prefs
        .getString(AppConsts.countryLocalData);
  }

  static Future<void> initDataForLocation(
      LocationService locationService,
      WeatherService weatherService,
      ImageService imgService,
      BuildContext context) async {
    // ignore: use_build_context_synchronously
    if (isFirstTime(context)) {
      final data = await locationService.getLocation();
      if (data != null) {
        await Future.wait([
          weatherService.getForecast(data.latitude ?? 0, data.longitude ?? 0),
          weatherService.getFutureWeather(
              data.latitude ?? 0, data.longitude ?? 0),
          imgService.getImage(await locationService.getAddress())
        ]);
      }
    }
    // ignore: use_build_context_synchronously
    await setFirstTime(context);
  }
}
