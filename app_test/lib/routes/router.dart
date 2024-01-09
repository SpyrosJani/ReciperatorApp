import 'package:app_test/ui/home/home_page.dart';
import 'package:app_test/ui/profile_setup/know_the_user.dart';
import 'package:flutter/material.dart';
import 'package:app_test/routes/router_constants.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings)  {
    switch(settings.name) {
      case landing: 
        return MaterialPageRoute(builder: (_) => const KnowTheUser());
      case homeRoute: 
        return MaterialPageRoute(builder: (_) => const HomePage());
      default: 
        return MaterialPageRoute( 
          builder: (_) => Scaffold (
            body: Center(child: Text('No route defined for ${settings.name}'))
          ),
        );
    }
  }
}