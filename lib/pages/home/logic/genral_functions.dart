import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/config/constants.dart';
import 'package:weather_app/data/providers/location_data.dart';
import 'package:weather_app/data/providers/persistence_provider.dart';
import 'package:weather_app/data/providers/weather_data.dart';
import 'package:weather_app/data/services/image_service.dart';
import 'package:weather_app/data/services/location_service.dart';
import 'package:weather_app/data/services/weather_service.dart';
import 'package:weather_app/util/context_extensions.dart';

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

  static Future<void> refreshLocationData(
      LocationService locationService,
      WeatherService weatherService,
      ImageService imgService,
      BuildContext context,
      String? latitude,
      String? longitude,
      String locationName) async {
    try {
      context.read<CountryData>().country = locationName;
      context.read<WeatherData>().lastUpdated = DateTime.now();

      await Future.wait([
        // ignore: use_build_context_synchronously
        context
            .read<PersistenceProvider>()
            .prefs
            .setString(AppConsts.countryLocalData, locationName),
        weatherService.getForecast(
            num.tryParse(latitude ?? '0')?.toDouble() ?? 0,
            num.tryParse(longitude ?? '0')?.toDouble() ?? 0),
        weatherService.getFutureWeather(
            num.tryParse(latitude ?? '0')?.toDouble() ?? 0,
            num.tryParse(longitude ?? '0')?.toDouble() ?? 0),
        imgService.getImage(locationName)
      ]);
    } catch (e) {
      // ignore: use_build_context_synchronously
      context.showSnackBar('AN error occured');
    }
  }
}
