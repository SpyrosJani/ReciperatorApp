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
          const Positioned(
            bottom: 107.0, 
            right: 94.0, 
            child: Button (type: 'Add Ingredient'))
        ]  
      ),
      floatingActionButton: const Button(type: 'Back'),
    );
  }
}