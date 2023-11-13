import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/config/constants.dart';
import 'package:weather_app/config/dimensions.dart';
import 'package:weather_app/config/routing_config.dart';
import 'package:weather_app/data/providers/location_data.dart';
import 'package:weather_app/data/providers/location_img.dart';
import 'package:weather_app/data/providers/persistence_provider.dart';
import 'package:weather_app/data/providers/repo_instance.dart';
import 'package:weather_app/data/providers/weather_data.dart';
import 'package:weather_app/gen/fonts.gen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  final dio = Dio(BaseOptions(
    connectTimeout: 50000.seconds,
    receiveTimeout: 5000.seconds,
  ));
  dio.interceptors.addAll([
    PrettyDioLogger(
      requestHeader: kDebugMode,
      requestBody: kDebugMode,
      responseBody: kDebugMode,
      responseHeader: false,
      error: kDebugMode,
      compact: false,
      maxWidth: 90,
    ),
  ]);

  final prefs = await SharedPreferences.getInstance();

  // if (kDebugMode) await prefs.clear();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => PersistenceProvider(prefs)),
      ChangeNotifierProvider(create: (context) => RepoProvider(dio)),
      ChangeNotifierProvider(create: (context) => LocationImageProvider()),
      ChangeNotifierProvider(create: (context) => WeatherData()),
      ChangeNotifierProvider(create: (context) => CountryData()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(
          DesignDimensions.deviceWidth, DesignDimensions.deviceHeight),
      splitScreenMode: true,
      builder: (context, child) => GlobalLoaderOverlay(
        useDefaultLoading: true,
        overlayOpacity: 0.4,
        duration: 250.milliseconds,
        reverseDuration: 250.milliseconds,
        switchInCurve: Curves.easeIn,
        switchOutCurve: Curves.easeOut,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: navigatorKey,
          routes: AppRouter.routes,
          onGenerateRoute: AppRouter.onGenerateRoute,
          title: AppConsts.appName,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
            useMaterial3: true,
            fontFamily: FontFamily.roboto,
          ),
        ),
      ),
    );
  }
}
