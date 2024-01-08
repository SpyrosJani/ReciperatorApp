import 'package:flutter/material.dart';
import 'package:app_test/app/colors.dart';
import 'package:app_test/app/buttons.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key, 
    this.title = 'Default'
    });

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //the following overlay replaces the "add ingredient" button with the choices to either
  //add via keyboard/microphone or via camera 
  void _showOverlay(BuildContext context) async {

    OverlayState? overlayState = Overlay.of(context);
    OverlayEntry? overlayEntry1;

    overlayEntry1 = OverlayEntry(builder: (context) {
      return Positioned.fill(
        child:GestureDetector(

          //we add the GestureDetector in order to make the overlay disappear when we press anywhere in the screen
          onTap: () {
            overlayEntry1?.remove();
          },

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

    overlayState.insertAll([overlayEntry1]); 

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {}, 
          child: const Icon(Icons.menu))
      ), 
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
            bottom: 107.0, 
            right: 94.0, 
            child: Button (type: 'Add', label:'Add Ingredients', onPressed: () {_showOverlay(context);},))
        ]  
      ),
      floatingActionButton: Button(type: 'Back', label:'Back', onPressed: () {}),
    );
  }
}