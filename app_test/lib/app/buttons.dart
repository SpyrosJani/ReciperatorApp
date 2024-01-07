import 'package:app_test/app/custom_icons_icons.dart';
import 'package:flutter/material.dart';
import 'package:app_test/app/colors.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.type,
    });

    final String type;

  @override
  Widget build(BuildContext context) {
    if (type == 'Back') {
      return FloatingActionButton.extended(
        backgroundColor: AppColors.primary,
        onPressed: () {}, 
        label: const Text('Back'), 
        icon: const Icon(CustomIcons.BackIcon),
      );
    }
    else if (type == 'Add Ingredient'){
      return FloatingActionButton.extended(
        backgroundColor: AppColors.secondary,
        onPressed: () {}, 
        label: const Text(
          'Add Ingredients',
          style: TextStyle(
            color: AppColors.white
          )), 
        icon: const Icon(
          Icons.add, 
          color: AppColors.white),
      );
    }
    else if (type == 'Review'){
      return ElevatedButton(
        onPressed: () {}, 
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary)
        ),
        child: const Text("Review"),
      );
    }
    else if (type == 'Redirect'){
      return ElevatedButton(
        onPressed: () {}, 
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.onPrimary,
          foregroundColor: AppColors.primary,
        ),
        child: const Text("Check it out"),
      );
    }
    return TextButton(
      onPressed: () {},
      child: const Text('Wrong type'), 
    );
  }
}