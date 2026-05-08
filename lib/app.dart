import 'package:flutter/material.dart';

import 'core/router/route_generator.dart';
import 'core/router/route_names.dart';

import 'core/theme/app_theme.dart';

class WingaProApp extends StatelessWidget {
  const WingaProApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      // GLOBAL APP THEME
      theme: AppTheme.lightTheme,

      // FIRST SCREEN
      initialRoute: RouteNames.login,

      // NAVIGATION SYSTEM
      onGenerateRoute:
          RouteGenerator.generateRoute,
    );
  }
}