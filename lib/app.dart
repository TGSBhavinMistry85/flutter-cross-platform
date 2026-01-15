import 'package:flutter/material.dart';
import 'core/routing/app_routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Desktop App',
      initialRoute: AppRoutes.login,
      routes: AppRoutes.routes,
    );
  }
}