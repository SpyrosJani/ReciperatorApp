import 'package:flutter/material.dart';
import 'package:reciperator_app/app/textfields.dart';
import 'package:reciperator_app/app/buttons.dart';
import 'package:reciperator_app/ui/myapp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reciperator_app/routes/router_constants.dart';


//The basic Login Page
class LoginHomePage extends StatefulWidget {
  const LoginHomePage({super.key});

  @override
  State<LoginHomePage> createState() => _LoginHomePageState();
}

class _LoginHomePageState extends State<LoginHomePage> {
  //Controllers to handle the text input from the user
  late final TextEditingController loginController;
  late final TextEditingController passwordController;

  //initialize the controllers
  @override 
  void initState() {
    loginController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  // Clean up the controller when the widget is disposed.
  @override
  void dispose() {
    loginController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  //check if this user exists
  Future<void> checkuser() async{
    final username = loginController.text;
    final psw = passwordController.text;

    const aux = "@reciperator.com";
    String usremail = '$username$aux';
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: usremail,
        password: psw,
      );
    } 
    on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(seconds: 3),
            content: Text('User does not exist.'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          )
        );

        return;
      } 
      else if (e.code == 'wrong-password') {
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(seconds: 3),
            content: Text('Wrong Password.'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          )
        );

        return;
      }

      //If everything is ok, then we navigate to the home screen
      Navigator.pushNamed(context, homeRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    //Percentage stuff, to cover a percentage of the screen 
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        hideKeyboard(context); // Hide keyboard when tapping outside of widgets
      },    
      child: buildBackground(
        Scaffold(
          resizeToAvoidBottomInset: false,
          //The top bar part of the code
          appBar: null,
          //The top bar part of the code
          //The main body of the code
          //First, i want everything to be in the center
          body: FutureBuilder( 
            future: Firebase.initializeApp(
                options: const FirebaseOptions(
                  apiKey: 'AIzaSyDjyww9nfeBHtHImZ1MGLS3pJ5N5UaclxI',
                  appId: '1:1019351826894:android:678fc7a30532f4b9246b9f',
                  messagingSenderId: '1019351826894',
                  projectId: 'reciperator-app-main',
                ),
              ),
              builder: (context, snapshot) {
                return Center(
                  child: 
                    //Everything will be within this main column, so all components will be children of this
                    Column(
                      children:[
                        //-----------Leave some space from the upper part-----------
                        SizedBox(height: 0.2*h),
                        //-----------"Welcome" text-----------
                        const Text(
                          "Welcome!" ,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                          )
                        ),
                        //-----------"Login to find the best recipes!" text-----------
                        const Text(
                          "Login to find the best recipes!",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                          )
                        ),
                        //-----------Some space-----------
                        SizedBox(height: 0.02*h),
                        //-----------Login username Textfield-----------
                        CustomTextfield(text: 'Username', width: w, mycontroller: loginController, v: false),
                        //-----------Some space-----------
                        SizedBox(height: 0.02*h),
                        //-----------Password username Textfield-----------
                        CustomTextfield(text: 'Password', width: w, mycontroller: passwordController, v: true),
                        //-----------Some space-----------
                        SizedBox(height: 0.02*h),
                        //-----------Login Button-----------
                        Button (type: 'Miltos', label:'Login', onPressed: () async {checkuser();}),
                        //-----------Some space-----------
                        SizedBox(height: 0.02*h),
                        //-----------"Login to find the best recipes!" text-----------
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                          )
                        ),
                        //-----------Some space-----------
                        SizedBox(height: 0.02*h),
                        //-----------SignUp Button-----------
                        Button (type: 'Miltos', label:'Sign Up', onPressed: () {Navigator.pushNamed(context, signupRoute);}),
                        //-----------Adding the image-----------
                        Image.asset(
                          'assets/image1.jpg', 
                          width: 0.03*h, 
                          height: 0.05*w, 
                        ),
                      ]
                    )
                  );
              }
          )
        )
      )
    );
  }
}