import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/config/constants.dart';
import 'package:weather_app/data/models/img.dart';
import 'package:weather_app/data/providers/location_img.dart';
import 'package:weather_app/data/providers/persistence_provider.dart';
import 'package:weather_app/data/providers/repo_instance.dart';
import 'package:weather_app/data/repository/image_api.dart';

class ImageService {
  final ImageRestClient _client;
  final SharedPreferences _prefs;
  final BuildContext context;
  final Logger _logger;

  ImageService(this.context)
      : _client = context.read<RepoProvider>().imageClient,
        _prefs = context.read<PersistenceProvider>().prefs,
        _logger = Logger();

  Future<void> getImage(String country) async {
    try {
      final response = await _client.getImage(
          AppConsts.unsplashApiKey, country, 1, 1, 'portrait');

      await _prefs.setString(
          AppConsts.imageLocalData, jsonEncode(response.toJson()));

      // ignore: use_build_context_synchronously
      context.read<LocationImageProvider>().locationImage =
          response.results.first.urls.regular;
    } catch (e, t) {
      if (kDebugMode) {
        _logger.e(e);
        _logger.t(t);
      }
    }
  }

  void initData() {
    try {
      context.read<LocationImageProvider>().locationImage = null;
      final existingData = _prefs.getString(AppConsts.imageLocalData);

      if (existingData != null) {
        // ignore: use_build_context_synchronously
        context.read<LocationImageProvider>().locationImage =
            UnsplashResult.fromJson(jsonDecode(existingData))
                .results
                .first
                .urls
                .regular;
      }
    } catch (e, t) {
      if (kDebugMode) {
        _logger.e(e);
        _logger.t(t);
      }
    }
  }
}
