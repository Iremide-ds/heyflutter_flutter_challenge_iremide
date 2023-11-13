import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/config/dimensions.dart';
import 'package:weather_app/data/providers/location_img.dart';
import 'package:weather_app/data/providers/weather_data.dart';
import 'package:weather_app/data/services/image_service.dart';
import 'package:weather_app/data/services/location_service.dart';
import 'package:weather_app/data/services/weather_service.dart';
import 'package:weather_app/pages/home/logic/genral_functions.dart';
import 'package:weather_app/util/date_extensions.dart';
import 'package:weather_app/widgets/atmospheric_conditions.dart';
import 'package:weather_app/widgets/current_weather.dart';
import 'package:weather_app/widgets/future_weather.dart';
import 'package:weather_app/widgets/location_picker.dart';
import 'package:weather_app/widgets/placeholder.dart';

final GlobalKey<ScaffoldState> _key = GlobalKey();

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final WeatherService _weatherService;
  late final ImageService _imgService;
  late final LocationService _locationService;

  void _init() {
    _weatherService = WeatherService(context);
    _imgService = ImageService(context);
    _locationService = LocationService(context);
  }

  @override
  void initState() {
    _init();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      GeneralFunctions.initData(
          _locationService, _weatherService, _imgService, context);
      GeneralFunctions.initDataForLocation(
          _locationService, _weatherService, _imgService, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white54,
      child: Stack(
        children: [
          Consumer<LocationImageProvider>(
            builder: (context1, listener, child) {
              return CachedNetworkImage(
                imageUrl: listener.locationImage,
                imageBuilder: (context, imageProvider) => Container(
                    height: DesignDimensions.deviceHeight.h,
                    width: DesignDimensions.deviceWidth.w,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                    ),
                    child: child),
                placeholder: (context, url) => Container(
                    height: DesignDimensions.deviceHeight.h,
                    width: DesignDimensions.deviceWidth.w,
                    color: Colors.white),
                errorWidget: (context, url, error) => Container(
                  height: DesignDimensions.deviceHeight.h,
                  width: DesignDimensions.deviceWidth.w,
                  color: Colors.white,
                  child: const Center(child: Icon(Icons.error)),
                ),
              );
            },
          ),
          Scaffold(
              key: _key,
              backgroundColor: Colors.black38,
              drawer: const Drawer(),
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.transparent,
                leadingWidth: 110.w,
                scrolledUnderElevation: 0,
                leading: const LocationPicker(),
                actions: [
                  Padding(
                    padding: EdgeInsets.only(right: 24.w),
                    child: IconButton(
                      onPressed: () {
                        _key.currentState?.openDrawer();
                      },
                      icon: Icon(Icons.menu, color: Colors.white, size: 32.w),
                    ),
                  ),
                ],
              ),
              body: Container(
                height: DesignDimensions.deviceHeight.h,
                width: DesignDimensions.deviceWidth.w,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                child: Consumer<WeatherData>(
                  builder: (context, listener, child) {
                    final currentData = listener.weatherData;

                    return currentData != null
                        ? Column(children: [
                            Text(DateTime.now().toMMDD,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center),
                            Text(
                              'Updated on ${(listener.lastUpdated ?? DateTime.now()).format}',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            const Spacer(),
                            CurrentWeather(forecast: currentData),
                            const Spacer(),
                            AtmosphericConditions(forecast: currentData),
                            SizedBox(height: 24.h),
                            FutureWeatherDisplay(
                                futureWeather: listener.futureWeatherData),
                          ])
                        : child!;
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomPlaceholder(height: 47.h, width: 144.w),
                      CustomPlaceholder(height: 19.h, width: 192.w),
                      CustomPlaceholder(height: 227.h, width: 154.3.w),
                      CustomPlaceholder(height: 80.h, width: 345.w),
                      CustomPlaceholder(height: 153.h, width: 345.w),
                    ],
                  )
                      .animate(
                          autoPlay: true,
                          onComplete: (controller) => controller.repeat())
                      .shimmer(delay: 150.ms, duration: 1.seconds),
                ),
              )),
        ],
      ),
    );
  }
}
