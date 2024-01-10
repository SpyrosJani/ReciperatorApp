import 'package:flutter/material.dart';
import 'package:once_again/app/textfields.dart';
import 'package:once_again/app/buttons.dart';
import 'package:once_again/ui/signup_page.dart';
import 'package:once_again/ui/myapp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


//The basic Login Page
class LoginHomePage extends StatefulWidget {
  const LoginHomePage({super.key, required this.title});

  final String title;

  @override
  State<LoginHomePage> createState() => _LoginHomePageState();
}


//The following code in comments needs to be called every time we wanna access the database
/*WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);*/
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
  void checkuser() async{
    final username = loginController.text;
    final psw = passwordController.text;

    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    print((username, psw));
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
      child: Scaffold(
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
                  Button (type: 'Miltos', label:'Sign Up', onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignUpPage(title: 'SignUp')),
                    );
                  }),
                  //-----------Adding the image-----------
                  Image.asset(
                    'images/image1.jpg', 
                    width: 0.3*h, 
                    height: 0.5*w, 
                  )
                ]
              )
          )
        )
    );
  }
}