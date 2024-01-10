import 'package:flutter/material.dart';
import 'package:once_again/ui/login_homepage.dart';

Widget buildBackground(Widget child) {
  return Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.green, Colors.black],
        tileMode: TileMode.clamp,
      ),
    ),
    child: child,
  );
}

void hideKeyboard(BuildContext context) {
  FocusScope.of(context).unfocus(); // Clear focus from any focused widget
  FocusScope.of(context).requestFocus(FocusNode()); // Request focus on an empty FocusNode
}

/*
showAlertDialog(BuildContext context, final x) {

  // set up the button
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () { },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Problem!"),
    content: Text(x),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
*/

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //Giving name
      title: 'Flutter Demo',
      //Making the background transparent and giving access to the flutter material
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.transparent,
      ),
      //Making the background colour fading from green to black (top->bottom)
      home: buildBackground(const LoginHomePage(title: 'Sign Up/Login')),
    );
  }
}