import 'package:flutter/material.dart';
import 'package:grammar_app/core/services/navigator.dart';
import 'package:grammar_app/domain/entities/theme_entity.dart';
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
      };

  @override
  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case NavigationRouteNames.oneTheme:
        final group = settings.arguments is ThemeEntity
            ? settings.arguments as ThemeEntity
            : const ThemeEntity(
                groupId: -1,
                id: -1,
                title: 'theme not found',
                pathToContent: '');
        return MaterialPageRoute(
          builder: (context) => ThemeScreenWrapperProvider(group: group),
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

  void showOneTheme(ThemeEntity group) {
    navigatorKey.currentState?.pushNamed(
      NavigationRouteNames.oneTheme,
      arguments: group,
    );
  }

  // void showLessonDetailsScreen(LessonEntity data) {
  //   navigatorKey.currentState
  //       ?.pushNamed(NavigationRouteNames.lessonDetailsScreen, arguments: data);
  // }

}
