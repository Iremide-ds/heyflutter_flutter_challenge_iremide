import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/data/models/current_weather_display.dart';
import 'package:weather_app/data/models/forecast.dart';
import 'package:weather_app/data/services/weather_service.dart';
import 'package:weather_app/util/num_extensions.dart';
import 'package:weather_app/widgets/placeholder.dart';

class CurrentWeather extends StatefulWidget {
  final WeatherForecast? forecast;
  const CurrentWeather({super.key, required this.forecast});

  @override
  State<CurrentWeather> createState() => _CurrentWeatherState();
}

class _CurrentWeatherState extends State<CurrentWeather> {
  late final WeatherService _service;

  CurrentWeatherDisplay? _currentWeather;

  void _init() {
    _service = WeatherService(context);
    _changeData();
  }

  void _changeData() {
    if (widget.forecast != null) {
      _currentWeather = _service.getCurrentWeather(widget.forecast!);
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        setState(() {});
      });
    } else {
      _currentWeather = null;
    }
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CurrentWeather oldWidget) {
    _changeData();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 237.h, minWidth: 154.3.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _currentWeather == null
            ? [const Expanded(child: CustomPlaceholder())]
            : [
                CachedNetworkImage(
                  imageUrl: _currentWeather!.icon,
                  imageBuilder: (context, imageProvider) => Container(
                    height: 95.h,
                    width: 95.w,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  placeholder: (context, url) =>
                      Container(height: 95.h, width: 95.w, color: Colors.white),
                  errorWidget: (context, url, error) => RepaintBoundary(
                    child: Container(
                      height: 95.h,
                      width: 95.w,
                      color: Colors.grey.withOpacity(0.5),
                      // child: const Center(child: Icon(Icons.error)),
                    )
                        .animate(
                            autoPlay: true,
                            onComplete: (controller) => controller.repeat())
                        .shimmer(delay: 150.ms, duration: 1.seconds),
                  ),
                ),
                Text(
                  _currentWeather!.description,
                  style: TextStyle(
                    fontSize: 40.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${_currentWeather!.temperature.toCelcius()}°',
                        style: TextStyle(
                          fontSize: 86.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: '\u1d9c',
                        style: TextStyle(
                          fontSize: 86.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontFeatures: const [FontFeature.superscripts()],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
      ),
    );
  }
}
