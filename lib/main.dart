import 'package:flutter/material.dart';
import 'package:grammar_app/presentation/pages/greeting/greeting_screen.dart';
import 'package:grammar_app/theme.dart';
import 'package:provider/provider.dart';
import 'injection.dart' as di; // di = dependency injection

import 'presentation/core/services/theme_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
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
        themeMode: themeService.isDarkModeOn ? ThemeMode.dark : ThemeMode.light,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        home: const GreetingScreenWrapperProvider(),
      );
    });
  }
}
