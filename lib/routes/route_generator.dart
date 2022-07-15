import 'package:flutter/material.dart';
import 'package:spents_app/screens/index_page.dart';

import '../screens/login_page.dart';
import '../screens/new_spent_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const IndexPage());
      case '/new-spent':
        return MaterialPageRoute(builder: (_) => const NewSpentPage());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginPage());
    }
    return _errorRoute();
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
