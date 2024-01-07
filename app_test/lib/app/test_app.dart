//import 'package:app_test/app/themes.dart';
import 'package:flutter/material.dart';
import 'package:app_test/ui/home/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp ({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Test App', 
      //theme: AppThemeDataFactory.prepareThemeData(),
      home: HomePage(title: 'Welcome, User!')
    );
  }
}