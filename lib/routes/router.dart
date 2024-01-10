import 'package:reciperator_app/ui/home/home_page.dart';
import 'package:reciperator_app/ui/home/my_reviews.dart';
import 'package:reciperator_app/ui/login_homepage.dart';
import 'package:reciperator_app/ui/signup_page.dart';
import 'package:reciperator_app/ui/myprofile.dart';
import 'package:reciperator_app/ui/profile_setup/know_the_user.dart';
import 'package:flutter/material.dart';
import 'package:reciperator_app/routes/router_constants.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings)  {
    switch(settings.name) {
      case landing: 
        return MaterialPageRoute(builder: (_) => const KnowTheUser());
      case homeRoute: 
        return MaterialPageRoute(builder: (_) => const HomePage());
      case reviewRoute: 
        return MaterialPageRoute(builder: (_) => const MyReviews());
      case loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginHomePage());
      case signupRoute:
        return MaterialPageRoute(builder: (_) => const SignUpPage());
      case myprofileRoute:
        return MaterialPageRoute(builder: (_) => const MyProfilePage());
      case knowuserRoute:
        return MaterialPageRoute(builder: (_) => const KnowTheUser());
      default: 
        return MaterialPageRoute( 
          builder: (_) => Scaffold (
            body: Center(child: Text('No route defined for ${settings.name}'))
          ),
        );
    }
  }
}