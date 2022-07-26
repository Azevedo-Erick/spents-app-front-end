import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spents_app/controllers/new_data_controller.dart';
import 'package:spents_app/controllers/transactions_overview_controller.dart';
import 'routes/route_generator.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<NewDataController>(
          create: (_) => NewDataController(),
        ),
        ChangeNotifierProvider<TransactionOverviewController>(
          create: (_) => TransactionOverviewController(),
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
      initialRoute: '/login',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
