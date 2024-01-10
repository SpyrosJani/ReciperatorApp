import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reciperator_app/ui/myapp.dart';

void main(){

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent
    )
  );
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}




