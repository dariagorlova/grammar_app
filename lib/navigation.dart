import 'package:flutter/material.dart';
import 'package:grammar_app/core/services/navigator.dart';
import 'package:grammar_app/presentation/pages/all_themes/all_themes_screen.dart';
import 'package:grammar_app/presentation/pages/greeting/greeting_screen.dart';
import 'package:grammar_app/presentation/pages/one_theme/themes_screen.dart';

class NavigationImpl implements AppNavigation {
  @override
  String get initialRoute => NavigationRouteNames.mainScreen;

  @override
  Map<String, Widget Function(BuildContext context)> get routes => {
        NavigationRouteNames.mainScreen: (context) {
          return const GreetingScreenWrapperProvider();
        },
        NavigationRouteNames.allThemes: (context) =>
            const AllThemesScreenWrapperProvider(),
        NavigationRouteNames.oneTheme: (context) => const ThemeScreen(),
      };

  @override
  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case NavigationRouteNames.oneTheme:
        return MaterialPageRoute(
          builder: (context) => const ThemeScreen(),
        );

      case NavigationRouteNames.allThemes:
        return MaterialPageRoute(
          builder: (context) => const AllThemesScreenWrapperProvider(),
        );

      default:
        const widget = Scaffold(body: Center(child: Text('Error')));
        return MaterialPageRoute(builder: (context) => widget);
    }
  }
}

class NavigationActions {
  static const instance = NavigationActions._();
  const NavigationActions._();
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  // на попередню сторінку
  void returnToPreviousPage() {
    navigatorKey.currentState?.pop();
  }

  void showAllTheme() {
    navigatorKey.currentState?.pushNamed(NavigationRouteNames.allThemes);
  }

  void showOneTheme() {
    navigatorKey.currentState?.pushNamed(NavigationRouteNames.oneTheme);
  }

  // void showLessonDetailsScreen(LessonEntity data) {
  //   navigatorKey.currentState
  //       ?.pushNamed(NavigationRouteNames.lessonDetailsScreen, arguments: data);
  // }

}
