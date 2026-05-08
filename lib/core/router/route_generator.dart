import 'package:flutter/material.dart';

import '../../features/auth/login_page.dart';
import '../../features/customer/customer_home.dart';
import '../../features/producer/producer_home.dart';
import '../../features/admin/admin_dashboard.dart';
import '../../features/auth/register_page.dart';

import 'route_names.dart';

class RouteGenerator {

  static Route<dynamic> generateRoute(RouteSettings settings) {

    switch (settings.name) {

      case RouteNames.login:
        return MaterialPageRoute(builder: (_) => const LoginPage());

      case RouteNames.register:
        return MaterialPageRoute(builder: (_) => const RegisterPage());

      case RouteNames.customerHome:
        return MaterialPageRoute(builder: (_) => const CustomerHome());

      case RouteNames.producerHome:
        return MaterialPageRoute(builder: (_) => const ProducerHome());

      case RouteNames.adminDashboard:
        return MaterialPageRoute(builder: (_) => const AdminDashboard());

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text("Route not found")),
          ),
        );
    }
  }
}