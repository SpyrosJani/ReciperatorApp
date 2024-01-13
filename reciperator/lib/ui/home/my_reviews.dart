import 'package:flutter/material.dart';
import 'package:reciperator/app/colors.dart';
import 'package:reciperator/ui/home/menu.dart';
import 'package:reciperator/app/recipe_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reciperator/app/test_app.dart';

class MyReviews extends StatefulWidget {
  const MyReviews({super.key});

  @override
  State<MyReviews> createState() => _MyReviewsState();
}

class _MyReviewsState extends State<MyReviews> {
  
  Future<List<RecipeCard>?> findingreviews() async{
    //First extracting all the recommendations related to this user
    FirebaseAuth auth = FirebaseAuth.instance;
    List<RecipeCard> reviews = [];
    User? user = auth.currentUser;
    if (user != null) {
      String uid = user.uid;
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('recipes')
        .where('user_id', isEqualTo: uid)
        .get();

        for (QueryDocumentSnapshot document in querySnapshot.docs) {
          
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
          if(data['review'] > 0){
            RecipeCard aux = RecipeCard(title: data['title'], review: data['review'], image: data['image'], 
            overlay: () {}, link: data['link'], isReview: true);
            reviews.add(aux);
          }

        }
        
      }

    return  reviews;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          "My Reviews", 
          style: TextStyle(fontSize: 30)
        ),
        backgroundColor: AppColors.green,
      ), 
      //backgroundColor: Colors.transparent,
      drawer: const Menu(), 
      body: FutureBuilder<List<RecipeCard>?>(
        future: findingreviews(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } 
          else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } 
          else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return buildBackground(const Center(
              child: Text(
                'No reviews yet.',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                )
                )
              )
            );
          } 
          else {
            List<Widget> recommendationWidgets = snapshot.data!;
            
            return Stack(
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
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left:26, top: 138),
                        child: Column(
                          children: recommendationWidgets
                        )
                      )     
                    ],
                  )
                ),
              ]  
            );
          }
        }
      ) 
    );
  }
}