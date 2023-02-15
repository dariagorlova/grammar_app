import 'package:flutter/material.dart';

abstract class NavigationRouteNames {
  static const mainScreen = '/';
  static const allThemes = '/all_themes';
  static const oneTheme = '/theme';
}

abstract class AppNavigation {
  String get initialRoute;
  Map<String, Widget Function(BuildContext context)> get routes;
  Route<Object> onGenerateRoute(RouteSettings settings);
}
