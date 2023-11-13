import 'dart:developer';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:weather_app/config/dimensions.dart';
import 'package:weather_app/data/models/forecast.dart';
import 'package:weather_app/util/date_extensions.dart';
import 'package:weather_app/util/num_extensions.dart';
import 'package:weather_app/widgets/placeholder.dart';

class FutureWeatherDisplay extends StatelessWidget {
  final List<WeatherForecast2>? _futureWeather;
  FutureWeatherDisplay(
      {super.key, required WeatherForecastMultiple? futureWeather})
      : _futureWeather = futureWeather?.list.where((WeatherForecast2 element) {
          final index1 = futureWeather.list.indexOf(element);
          bool result = false;

          if (index1 != 0) {
            result = (futureWeather.list[index1].dtTxt.month ==
                        futureWeather.list[index1 - 1].dtTxt.month &&
                    futureWeather.list[index1].dtTxt.day >
                        futureWeather.list[index1 - 1].dtTxt.day) ||
                (futureWeather.list[index1].dtTxt.month >
                    futureWeather.list[index1 - 1].dtTxt.month);
          } else {
            result = false;
          }
          return result;
        }).toList();

  @override
  Widget build(BuildContext context) {
    log(_futureWeather?.length.toString() ?? 'null');
    return Container(
      width: DesignDimensions.deviceWidth.w,
      height: 153.h,
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 19.w),
      decoration: BoxDecoration(
        color: const Color(0xff535353).withOpacity(0.6),
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _futureWeather?.length ?? 5,
        separatorBuilder: (context, index) => SizedBox(width: 32.w),
        itemBuilder: (context, index) {
          log(index.toString());
          try {
            return _Details(_futureWeather?.isEmpty == false
                ? _futureWeather![index]
                : null);
          } catch (e, t) {
            final _logger = Logger();
            _logger.e(e);
            _logger.t(t);
            return const _Details(null);
          }
        },
      ),
    );
  }
}

class _Details extends StatelessWidget {
  final WeatherForecast2? data;
  const _Details(this.data, {Key? key}) : super(key: key);

  TextStyle get _style => TextStyle(
      fontSize: 14.sp, fontWeight: FontWeight.w400, color: Colors.white);

  @override
  Widget build(BuildContext context) {
    return data == null
        ? Container(
            height: 119.h,
            width: 50.w,
            color: Colors.grey.withOpacity(0.4),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomPlaceholder(height: 18.h, width: 49.w),
                  CustomPlaceholder(height: 32.h, width: 41.w),
                  CustomPlaceholder(height: 19.h, width: 26.w),
                  CustomPlaceholder(height: 35.h, width: 23.w),
                ]),
          )
            .animate(
                autoPlay: true, onComplete: (controller) => controller.repeat())
            .shimmer(delay: 150.ms, duration: 1.seconds)
        : SizedBox(
            height: 119.h,
            width: 50.w,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    data!.dtTxt.toDDMM,
                    style: _style,
                  ),
                  CachedNetworkImage(
                    imageUrl:
                        'https://openweathermap.org/img/wn/${data!.weather.first.icon}@2x.png',
                    imageBuilder: (context, imageProvider) => Container(
                      height: 32.h,
                      width: 42.w,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => Container(
                        height: 32.h, width: 42.w, color: Colors.white),
                    errorWidget: (context, url, error) => RepaintBoundary(
                      child: Container(
                        height: 32.h,
                        width: 42.w,
                        color: Colors.grey.withOpacity(0.5),
                      )
                          .animate(
                              autoPlay: true,
                              onComplete: (controller) => controller.repeat())
                          .shimmer(delay: 150.ms, duration: 1.seconds),
                    ),
                  ),
                  Text(
                    '${data!.main.temp.toCelcius()}°',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 23.h,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${data!.wind.speed}',
                          style: _style.copyWith(fontSize: 10.sp),
                        ),
                        Text(
                          'km/h',
                          style: _style.copyWith(fontSize: 10.sp),
                        ),
                      ],
                    ),
                  ),
                ]),
          );
  }
}
