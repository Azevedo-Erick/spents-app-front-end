import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spents_app/repositories/category_repository.dart';
import 'package:spents_app/repositories/transaction_repository.dart';

import 'routes/route_generator.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<CategoryRepository>(
          create: (_) => CategoryRepository(),
        ),
        ChangeNotifierProvider<TransactionRepository>(
          create: (_) => TransactionRepository(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
