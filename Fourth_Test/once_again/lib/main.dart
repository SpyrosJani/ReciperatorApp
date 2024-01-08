import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:once_again/ui/myapp.dart';

void main(){
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent
    )
  );
  runApp(const MyApp());
}




