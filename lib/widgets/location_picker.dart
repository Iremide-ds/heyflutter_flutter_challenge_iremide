import 'package:country_state_city/country_state_city.dart' as cs;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/config/dimensions.dart';
import 'package:weather_app/data/providers/location_data.dart';
import 'package:weather_app/data/services/image_service.dart';
import 'package:weather_app/data/services/location_service.dart';
import 'package:weather_app/data/services/weather_service.dart';
import 'package:weather_app/pages/home/logic/genral_functions.dart';
import 'package:weather_app/util/context_extensions.dart';

class LocationPicker extends StatefulWidget {
  final LocationService locationService;
  final WeatherService weatherService;
  final ImageService imageService;
  const LocationPicker(
      {super.key,
      required this.locationService,
      required this.weatherService,
      required this.imageService});

  @override
  State<LocationPicker> createState() => _LocationPickerState();
}

const double _borderRadius = 24;

class _LocationPickerState extends State<LocationPicker> {
  cs.City? _city;

  Future<void> _refresh() async {
    if (_city != null) {
      await GeneralFunctions.refreshLocationData(
          widget.locationService,
          widget.weatherService,
          widget.imageService,
          context,
          _city!.latitude,
          _city!.longitude,
          _city!.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        _city = await showModalBottomSheet<cs.City>(
          context: context,
          isScrollControlled: true,
          builder: (context) {
            return Container(
              height: 600.h,
              width: DesignDimensions.deviceWidth.w,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(_borderRadius.r),
                  topRight: Radius.circular(_borderRadius.r),
                ),
              ),
              child: FutureBuilder(
                  future: cs.getAllStates(),
                  builder: (context, snapshot) {
                    return snapshot.data != null
                        ? ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) =>
                                _State(state: snapshot.data![index]),
                          )
                        : const Center(child: CircularProgressIndicator());
                  }),
            );
          },
        );
        await _refresh();
      },
      child: Container(
        margin: EdgeInsets.only(left: 24.w),
        width: 73.w,
        height: 32.h,
        child: Row(
          children: [
            Icon(Icons.location_on, color: Colors.white, size: 31.44.w),
            Expanded(
              child: SizedBox(
                child: Text(
                  context.watch<CountryData>().country ?? '...',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _State extends StatelessWidget {
  final cs.State state;
  const _State({Key? key, required this.state}) : super(key: key);

  TextStyle get _style {
    return const TextStyle(color: Colors.black);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        final result = await showModalBottomSheet<cs.City>(
          context: context,
          builder: (context) {
            return Container(
              height: 600.h,
              width: DesignDimensions.deviceWidth.w,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              child: FutureBuilder(
                future: cs.getStateCities(state.countryCode, state.isoCode),
                builder: (context, snapshot) {
                  return snapshot.data != null
                      ? ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) =>
                              _City(city: snapshot.data![index]),
                        )
                      : const Center(child: CircularProgressIndicator());
                },
              ),
            );
          },
        );
        if (result != null) {
          // ignore: use_build_context_synchronously
          context.pop(result: result);
        }
      },
      title: Text(state.name, style: _style),
      subtitle: Text(state.isoCode, style: _style),
    );
  }
}

class _City extends StatelessWidget {
  final cs.City city;
  const _City({Key? key, required this.city}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => context.pop(result: city),
      title: Text(city.name),
    );
  }
}
