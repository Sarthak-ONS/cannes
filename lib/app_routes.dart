import 'package:cannes/Screens/firebase_init_screen.dart';
import 'package:cannes/Screens/home.dart';
import 'package:cannes/Screens/product_details_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return getMaterialPageRoute(const InitFirebaseScreen());

      case '/home':
        return getMaterialPageRoute(const HomeScreen());

      case '/productDetails':
        print(routeSettings.arguments);
        return getMaterialPageRoute(
            ProductDetailsScreen(pid: routeSettings.arguments.toString()));

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Please try again later'),
        ),
      ),
    );
  }

  MaterialPageRoute getMaterialPageRoute(Widget widget) {
    return MaterialPageRoute(builder: (_) => widget);
  }
}
