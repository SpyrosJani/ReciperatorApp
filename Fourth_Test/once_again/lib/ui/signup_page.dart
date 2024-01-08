import 'package:flutter/material.dart';
import 'package:once_again/app/textfields.dart';
import 'package:once_again/app/buttons.dart';
import 'package:once_again/ui/myapp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

//The basic Signup Page
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key, required this.title});

  final String title;

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}


//The following code in comments needs to be called every time we wanna access the database
/*WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);*/
class _SignUpPageState extends State<SignUpPage> {
  //Controllers to handle the text input from the user
  late final TextEditingController loginController;
  late final TextEditingController passwordController;
  late final TextEditingController passwordVerifyController;


  //initialize the controllers
  @override 
  void initState() {
    loginController = TextEditingController();
    passwordController = TextEditingController();
    passwordVerifyController = TextEditingController();
    super.initState();
  }

  // Clean up the controller when the widget is disposed.
  @override
  void dispose() {
    loginController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  //Checking if there exists a user with this name, then checking if password is strong enough
  //then if both passwords are the same. Shall all the controls passed, then the user is created
  //and driven to the screen to choose food types 
  void createuser(BuildContext context) async {
    //Taking the values of the user 
    final username = loginController.text;
    final psw = passwordController.text;
    final vpsw = passwordVerifyController.text;

    //Entering database
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  
    //Doing the proper controls/checks
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await firestore
      .collection('users')
      .where('username', isEqualTo: username)
      .get();

    if (querySnapshot.docs.isNotEmpty){
      const x = "Another user with this name exists!";

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 5),
          content: Text(x),
        )
      );

      return;
    }
    if(psw.length < 8){
      const x = "Password is too weak. Use at least 8 characters.";

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 5),
          content: Text(x),
        )
      );

      return;
    }
    if(psw != vpsw){
      const x = "Passwords don't match!";

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 5),
          content: Text(x),
        )
      );

      return;
    }
    //Now if everything is ok, we proceed to build the user

  }

  @override
  Widget build(BuildContext context) {
    //Percentage stuff, to cover a percentage of the screen 
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return 
      GestureDetector(
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
            body: Center(
              child: 
                //Everything will be within this main column, so all components will be children of this
                Column(
                  children:[
                    //-----------Leave some space from the upper part-----------
                    SizedBox(height: 0.2*h),
                    //-----------"Welcome" text-----------
                    const Text(
                      "Sign Up" ,
                      style: TextStyle(
                        fontSize: 30,
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
                    //-----------Password username Textfield-----------
                    CustomTextfield(text: 'Verify Password', width: w, mycontroller: passwordVerifyController, v: true),
                    //-----------Some space-----------
                    SizedBox(height: 0.02*h),
                    //-----------Create Account Button-----------
                    Button (type: 'Miltos', label:'Create Account', onPressed: () async {createuser(context);}),
                  ]
                )
            )
        )
      )
    );
  }
}