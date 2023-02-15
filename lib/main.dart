import 'package:flutter/material.dart';
import 'package:grammar_app/navigation.dart';
import 'package:grammar_app/theme.dart';
import 'package:provider/provider.dart';
import 'core/services/navigator.dart';
import 'core/services/theme_service.dart';

import 'package:grammar_app/service_locator.dart' as di;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  di.initDI();
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeService(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeService>(builder: (context, themeService, child) {
      return MaterialApp(
        navigatorKey: NavigationActions.navigatorKey,
        themeMode: themeService.isDarkModeOn ? ThemeMode.dark : ThemeMode.light,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        initialRoute: di.instance<AppNavigation>().initialRoute,
        routes: di.instance<AppNavigation>().routes,
        onGenerateRoute: di.instance<AppNavigation>().onGenerateRoute,
      );
    });
  }
}
