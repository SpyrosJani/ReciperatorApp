import 'package:app_test/routes/router_constants.dart';
import 'package:flutter/material.dart';
import 'package:app_test/app/colors.dart';
import 'package:app_test/app/buttons.dart';
import 'package:app_test/app/text_images.dart';

class KnowTheUser extends StatefulWidget {
  const KnowTheUser({super.key});

  @override
  State<KnowTheUser> createState() => _KnowTheUserState();
}

class _KnowTheUserState extends State<KnowTheUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      extendBodyBehindAppBar: true,
      
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient( 
                begin: Alignment.topCenter, 
                end: Alignment.bottomCenter,
                colors: AppColors.background,
              )
            )
          ),
          Positioned(
            top: 80, 
            left: MediaQuery.of(context).size.width/2-123,
            width: 246,
            child:const Center(
              child:Text(
              'Welcome to Reciperator!',
                style: TextStyle(
                  fontSize: 32.0, 
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center
              ),
            ),
            
          ),
          Positioned(
            top: 185, 
            left: MediaQuery.of(context).size.width/2-120, 
            width: 240,
            child:const Center(
              child: Text(
                'Complete this short survey to help us recommend dishes according to your tastes',
                style:TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
                maxLines: 3, 
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center
              )
            ) 
          ),
          Positioned(
            top: 320, 
            left: MediaQuery.of(context).size.width/2-120, 
            width: 245,
            child:const Center(
              child: Text(
                'What is your favorite cuisine?',
                style:TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center
              )
            ) 
          ),
          
          Positioned(
            bottom: 209, 
            left: MediaQuery.of(context).size.width/2-52, 
            child: Button (type: 'Continue', label:'Continue', onPressed: () {Navigator.pushNamed(context, homeRoute);},)
          ), 
          Positioned(
            bottom: 300,
            child: Container(
              height: 130.0,
              width: 353.0, 
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  ImageWithText(title:'Japanese', image: "https://picsum.photos/200/300"), 
                  ImageWithText(title:'Indian', image: "https://picsum.photos/200/300"),
                  ImageWithText(title:'Mediterranean', image: "https://picsum.photos/200/300"),
                  ImageWithText(title:'Arabic', image: "https://picsum.photos/200/300"),
                  ImageWithText(title:'German', image: "https://picsum.photos/200/300"),
                  ImageWithText(title:'Chinese', image: "https://picsum.photos/200/300"),
                  ImageWithText(title:'Greek', image: "https://picsum.photos/200/300"),
                ]
              )
            )
          )
        ]  
      ),
    );
  }
}