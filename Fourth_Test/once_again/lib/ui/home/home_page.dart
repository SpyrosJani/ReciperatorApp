import 'package:flutter/material.dart';
import 'package:reciperator_app/app/colors.dart';
import 'package:reciperator_app/app/buttons.dart';
import 'package:reciperator_app/ui/home/menu.dart';
import 'package:reciperator_app/ui/home/recipe_card.dart';


class HomePage extends StatefulWidget {
  const HomePage({
    super.key, 
    this.title = 'Welcome, User!',
    });

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

bool isOverlayVisible = false;

class _HomePageState extends State<HomePage> {

  
  late OverlayEntry overlayEntry1;
  //the following overlay replaces the "add ingredient" button with the choices to either
  //add via keyboard/microphone or via camera 

  void _hideOverlay(OverlayEntry overlayEntry1) {
    isOverlayVisible = false;
    
    overlayEntry1.remove();
  }
  void _showOverlay(BuildContext context) async {

    OverlayState? overlayState = Overlay.of(context);

    overlayEntry1 = OverlayEntry(builder: (context) {
      return Positioned.fill(
        child:GestureDetector(

          onTap: () {_hideOverlay(overlayEntry1);},
          //the following screen dictates that the screen darkens a bit when the overlay appears 
          //and determines the position of the buttons, according to Figma 
          child: Container(
            color: Colors.black.withOpacity(0.8),
            child: Stack(
              children: [
                Positioned(
                  left: 71.0, 
                  bottom: 200.0,
                  child: Button(type: 'Add', label:'Add', onPressed: () {},),
                ), 
                Positioned(
                  right: 67.0, 
                  bottom: 200.0,
                  child: Button(type: 'Add', label:'Scan', onPressed: () {},),
                ),
              ],
            )
          ) 
        )
      );
    });

    isOverlayVisible = true; 
    debugPrint('Overlay appeared, flag is $isOverlayVisible, it must be true');
    overlayState.insertAll([overlayEntry1]); 
    

  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Flag is $isOverlayVisible');
    return Scaffold(  
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          widget.title, 
          style: const TextStyle(fontSize: 30)
        ),
        backgroundColor: Colors.transparent,
      ), 
      backgroundColor: Colors.transparent,
      drawer: const Menu(), 
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
          const Positioned(
            left: 11, 
            top: 146,
            child: Text(
                  "You'll love these...",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  )
                ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:17, top: 178),
                  child: Row(
                    children: [ 
                      RecipeCard(title: 'Spanish Tortillas', review: 4.0, image: 'https://picsum.photos/200/300'),
                      RecipeCard(title: 'Chocolate Pancakes', review:3.4, image: 'https://picsum.photos/200/300'),
                    ]
                  )
                )     
              ],
            )
          ),
          Positioned(
            bottom: 90.0,  
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'You have no idea what to eat?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    )
                  )
                ),
                Button (type: 'Add', label:'Add Ingredients', onPressed: () {_showOverlay(context);},),
              ],
            )
          )
        ]  
      ),
    );
  }
}