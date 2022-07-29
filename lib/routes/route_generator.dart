import 'package:flutter/material.dart';
import 'package:spents_app/screens/transactions_overview.dart';

import '../screens/login_page.dart';
import '../screens/new_data.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/transactions-overview':
        return MaterialPageRoute(builder: (_) => const TransactionsOverview());
      case '/new-data':
        return MaterialPageRoute(builder: (_) => const NewData());
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
