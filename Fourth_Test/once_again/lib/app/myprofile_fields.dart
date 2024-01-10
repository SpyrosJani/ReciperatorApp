import 'package:flutter/material.dart';

class ProfileCustomTextfield extends StatelessWidget {
  const ProfileCustomTextfield({
    super.key,
    required this.text,
    required this.width,
    required this.mycontroller,
    });

    final String text;
    final double width;
    final TextEditingController mycontroller;

  @override
  Widget build(BuildContext context) {
    return 
      Container(
        width: 2/3 * width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0), // Adjust the corner radius here
          color: Colors.grey[200], // Change the background color here
        ),
        child: TextField(
        controller: mycontroller,
        decoration: InputDecoration(
          border: InputBorder.none, // Remove the default border
          hintText: text,
          contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        ),
      ),
    );
  }
}