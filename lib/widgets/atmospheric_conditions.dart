import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_app/config/dimensions.dart';
import 'package:weather_app/data/models/forecast.dart';
import 'package:weather_app/gen/assets.gen.dart';
import 'package:weather_app/util/num_extensions.dart';

class AtmosphericConditions extends StatelessWidget {
  final WeatherForecast? forecast;
  const AtmosphericConditions({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    return forecast == null
        ? Container(
            constraints: BoxConstraints(
                maxHeight: 80.h, maxWidth: DesignDimensions.deviceWidth.w),
          )
            .animate(
                autoPlay: true, onComplete: (controller) => controller.repeat())
            .shimmer(delay: 150.ms, duration: 1.seconds)
        : Container(
            constraints: BoxConstraints(
                maxHeight: 80.h, maxWidth: DesignDimensions.deviceWidth.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <_DescriptionAndDetail>[
                _DescriptionAndDetail(
                    icon: Assets.svg.iconHumidity.path,
                    title: 'Humidity',
                    description: '${forecast!.main.humidity}%'),
                _DescriptionAndDetail(
                    icon: Assets.svg.iconWind.path,
                    title: 'Wind',
                    description: '${forecast!.wind.speed}km/h'),
                _DescriptionAndDetail(
                    icon: Assets.svg.iconFeelsLike.path,
                    title: 'Feels like',
                    description: '${forecast!.main.feelsLike.toCelcius()}°'),
              ],
            ),
          );
  }
}

class _DescriptionAndDetail extends StatelessWidget {
  final String icon, title, description;
  const _DescriptionAndDetail(
      {Key? key,
      required this.icon,
      required this.title,
      required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 80.h, maxWidth: 61.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(icon, height: 30.h, width: 30.w),
          Text(
            title.toUpperCase(),
            style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white),
          ),
          Text(
            description,
            style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white),
          )
        ],
      ),
    );
  }
}
