import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/config/dimensions.dart';
import 'package:weather_app/data/providers/location_data.dart';

class LocationPicker extends StatefulWidget {
  const LocationPicker({super.key});

  @override
  State<LocationPicker> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              height: 600.h,
              width: DesignDimensions.deviceWidth.w,
              color: Colors.white,
              child: ListView.builder(
                itemCount: 0,
                itemBuilder: (context, index) => const Placeholder(),
              ),
            );
          },
        );
      },
      child: Container(
        margin: EdgeInsets.only(left: 24.w),
        width: 73.w,
        height: 32.h,
        child: Row(
          children: [
            Icon(Icons.location_on, color: Colors.white, size: 31.44.w),
            Text(
              context.watch<CountryData>().country ?? '...',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
      ),
    );
  }
}
