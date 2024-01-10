import 'package:flutter/material.dart';
import 'package:app_test/app/colors.dart';
import 'package:app_test/app/menu_buttons.dart';
import 'package:app_test/routes/router_constants.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack( 
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin:Alignment.topCenter,
                end:Alignment.bottomCenter,
                colors: AppColors.menuBackground,
              )
            )
          ),
          ListView(
            padding: EdgeInsets.zero,
            children:  [
               const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.transparent
                ),
                child: Center(
                  child: Text(
                    "Hi, User!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                    )
                  ),
                ),
              ),
              MenuButton(type: 'Home', text: 'Home Page', onTap: () {Navigator.pushNamed(context, homeRoute);}), 
              MenuButton(type: 'Profile', text: 'My Profile', onTap: () {}),
              MenuButton(type: 'Reviews', text:'My Reviews', onTap: () {Navigator.pushNamed(context, reviewRoute);}), 
              MenuButton(type: 'MealPlanner', text: 'My Meal Planner', onTap: () {}),
              MenuButton(type: 'LogOut', text: 'LogOut', onTap: () {})
            ],
          )        
        ]
      )
    );
  }
}