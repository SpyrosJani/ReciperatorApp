import 'package:flutter/material.dart';
import 'package:reciperator_app/app/myprofile_fields.dart';
import 'package:reciperator_app/app/buttons.dart';
import 'package:reciperator_app/ui/myapp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//The basic Signup Page
class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}


//The following code in comments needs to be called every time we wanna access the database
class _MyProfilePageState extends State<MyProfilePage> {
  //Controllers to handle the text input from the user
  late final TextEditingController emailController;
  late final TextEditingController phoneController;
  late final TextEditingController countryController;

  var _email;
  var _phone;
  var _country;

  //initialize the controllers
  @override 
  void initState() {
    emailController = TextEditingController();
    phoneController = TextEditingController();
    countryController = TextEditingController();
    super.initState();
  }

  // Clean up the controller when the widget is disposed.
  @override
  void dispose() {
    emailController.dispose();
    phoneController.dispose();
    countryController.dispose();
    super.dispose();
  }

  //Checking with what to fill these textboxes
  Future<void> checkexisted() async {
    //Entering firebase
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyDjyww9nfeBHtHImZ1MGLS3pJ5N5UaclxI',
        appId: '1:1019351826894:android:678fc7a30532f4b9246b9f',
        messagingSenderId: '1019351826894',
        projectId: 'reciperator-app-main',
      ),
    );
  
    //Detecting the user we are refering to
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await firestore
      .collection('users')
      .where('username', isEqualTo: widget.who)
      .get();
    //Extracting the data from this user
    final userData = querySnapshot.docs;
    
    /*if (userData != null && userData.containsKey('A') && userData['A'] != null && userData['A'] != '') {
      _country = userData['country'];
    } 
    else {
      _country = 'Insert country here';
    }

    if (userData != null && userData.containsKey('A') && userData['A'] != null && userData['A'] != '') {
      _email = userData['email'];
    } 
    else {
      _email = 'Insert email here';
    }

    if (userData != null && userData.containsKey('A') && userData['A'] != null && userData['A'] != '') {
      _phone = userData['phone'];
    } 
    else {
      _phone = 'Insert phone here';
    }*/
  }

  //In case changes are done, this functions makes them
  void commitchanges() async {

  }
  

  @override
  Widget build(BuildContext context) {
    //Percentage stuff, to cover a percentage of the screen 
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    checkexisted();

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
                      'Name here',
                      //widget.who ,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                      )
                    ),
                    //-----------Some space-----------
                    SizedBox(height: 0.02*h),
                    //-----------Email field-----------
                    ProfileCustomTextfield(text: _email, width: w, mycontroller: emailController),
                    //-----------Some space-----------
                    SizedBox(height: 0.02*h),
                    //-----------Phone field-----------
                    ProfileCustomTextfield(text: _phone, width: w, mycontroller: phoneController),
                    //-----------Some space-----------
                    SizedBox(height: 0.02*h),
                    //-----------Phone field-----------
                    ProfileCustomTextfield(text: _country, width: w, mycontroller: countryController),
                    //-----------Some space-----------
                    SizedBox(height: 0.02*h),
                    //-----------Commit changes-----------
                    Button (type: 'Miltos', label:'Change', onPressed: () async {commitchanges();}),
                  ]
                )
            )
        )
      )
    );
  }
}