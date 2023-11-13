import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart' as g;
import 'package:loader_overlay/loader_overlay.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/config/constants.dart';
import 'package:weather_app/config/dimensions.dart';
import 'package:weather_app/data/providers/location_data.dart';
import 'package:weather_app/data/providers/persistence_provider.dart';
import 'package:weather_app/util/context_extensions.dart';

class LocationService {
  final Location _location;
  // final Logger _logger;
  final BuildContext context;

  LocationService(this.context) : _location = Location();
  // _logger = Logger();

  LocationData? _data;

  Location get location => _location;

  Future<LocationData?> getLocation() async {
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      // ignore: use_build_context_synchronously
      context.loaderOverlay.hide();
      // ignore: use_build_context_synchronously
      await context
          .displayDialog2(AlertDialog.adaptive(
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Permissions',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        content: SizedBox(
          width: (DesignDimensions.deviceWidth - 50).w,
          child: Text(
            'Zing collects location data to enable Zing suggestions around you.',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              context.pop();
            },
            child: Text(
              'Continue',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ))
          .then((value) async {
        context.loaderOverlay.show();
        return serviceEnabled = await _location.requestService();
      });

      if (!serviceEnabled) {
        return null;
      }
      // ignore: use_build_context_synchronously
      context.loaderOverlay.hide();
    }

    PermissionStatus permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    _data = await _location.getLocation();
    return _data;
  }

  Future<String> getAddress({double? latitude, double? longitude}) async {
    List<g.Placemark> placemarks = await g.placemarkFromCoordinates(
        latitude ?? _data?.latitude ?? 0, longitude ?? _data?.longitude ?? 0);
    // ignore: use_build_context_synchronously
    await context.read<PersistenceProvider>().prefs.setString(
        AppConsts.countryLocalData, placemarks.first.administrativeArea ?? 'A');
    // ignore: use_build_context_synchronously
    context.read<CountryData>().country = placemarks.first.administrativeArea;
    return 'famous place in ${placemarks.first.administrativeArea ?? 'A'} state';
  }
}
