import 'package:flutter/material.dart';
import 'package:app_test/app/colors.dart';
import 'package:app_test/app/buttons.dart';
import 'package:app_test/ui/home/menu.dart';

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
        title: Text(widget.title),
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
          Positioned(
            bottom: 107.0, 
            right: 94.0, 
            child: Button (type: 'Add', label:'Add Ingredients', onPressed: () {_showOverlay(context);},))
        ]  
      ),
    );
  }
}