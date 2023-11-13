import 'package:flutter/material.dart';
import 'package:weather_app/pages/home/parent.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class AppRoutes {
  static const String root = '/';
}

class AppRouter {
  static final Map<String, Widget Function(BuildContext)> routes = {
    AppRoutes.root: (context) => const HomePage(),
  };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${settings.name} does not exist...',
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        );
    }
  }
}
