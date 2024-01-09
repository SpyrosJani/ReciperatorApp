import 'package:flutter/material.dart';

class ImageWithText extends StatelessWidget {
  const ImageWithText({
    super.key,
    required this.title,
    required this.image
    });

    final String title;
    final String image; 

  @override
  Widget build(BuildContext context) {
    return Container(
    margin: const EdgeInsets.symmetric(horizontal: 8.0),
    child: Column(
      children: [
        Container(
          width: 75.0, // Adjust the width as needed
          height: 75.0, // Adjust the height as needed
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.0),
            image: DecorationImage(
              image: NetworkImage(image),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        Text(title, style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
      ],
    ),
    );
  }
}