import 'package:app_test/ui/home/home_page.dart';
import 'package:app_test/ui/home/my_reviews.dart';
import 'package:app_test/ui/profile_setup/know_the_user.dart';
import 'package:app_test/ui/recipes/add_ingredients.dart';
import 'package:app_test/ui/recipes/recipes.dart';
import 'package:flutter/material.dart';
import 'package:app_test/routes/router_constants.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings)  {
    switch(settings.name) {
      case landing: 
        return MaterialPageRoute(builder: (_) => const KnowTheUser());
      case homeRoute: 
        return MaterialPageRoute(builder: (_) => const HomePage());
      case reviewRoute: 
        return MaterialPageRoute(builder: (_) => const MyReviews());
      case addIngredientsRoute: 
        return MaterialPageRoute(builder: (_) => const AddIngredients());
      case recipesRoute:
        return MaterialPageRoute(builder: (_) => const Recipes());
      default: 
        return MaterialPageRoute( 
          builder: (_) => Scaffold (
            body: Center(child: Text('No route defined for ${settings.name}'))
          ),
        );
    }
  }
}