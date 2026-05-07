import 'package:flutter/material.dart';
import 'core/router/route_generator.dart';
import 'core/router/route_names.dart';

class WingaProApp extends StatelessWidget {
  const WingaProApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      initialRoute: RouteNames.login,

      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}