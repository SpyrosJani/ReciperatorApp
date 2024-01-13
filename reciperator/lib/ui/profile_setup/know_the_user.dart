import 'package:reciperator/routes/router_constants.dart';
import 'package:flutter/material.dart';
import 'package:reciperator/app/colors.dart';
import 'package:reciperator/app/buttons.dart';
import 'package:reciperator/app/text_images.dart';
import 'package:reciperator/ui/profile_setup/food_images.dart';
import 'package:reciperator/ui/profile_setup/food_titles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';



class KnowTheUser extends StatefulWidget {
  const KnowTheUser({super.key});

  @override
  State<KnowTheUser> createState() => _KnowTheUserState();
}

class _KnowTheUserState extends State<KnowTheUser> {

  late OverlayEntry overlayEntry;

  void _hideOverlay(OverlayEntry overlayEntry1) {    
    overlayEntry1.remove();
  }
  void _showOverlay(BuildContext context, int category, List<ImageWithText> helper) async {
    List<String> titles = allTitles(category);
    List<String> images = allImages(category);
    OverlayState? overlayState = Overlay.of(context);

    overlayEntry = OverlayEntry(builder: (context) {
      return Positioned.fill(
        child:GestureDetector(

          onTap: () {},
          //the following screen dictates that the screen darkens a bit when the overlay appears 
          //and determines the position of the buttons, according to Figma 
          child: Container(
            color: Colors.black.withOpacity(0.9),
            width: 249, 
            height: 467,
            alignment: Alignment.center, 
            child: Stack(
              children: [
                Positioned(
                  width: MediaQuery.of(context).size.width/2,  
                  top: 100,
                  left: MediaQuery.of(context).size.width/4,
                  child:const DefaultTextStyle(
                    style: TextStyle(
                      color: Colors.white, 
                      fontSize: 24,
                    ),
                    maxLines: 3,
                    child: Text(
                      'Choose your favorite dishes',
                      textAlign: TextAlign.center,
                    ),
                  )
                ),                 
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width, 
                    height: 467,
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4, // Number of items in each row
                        crossAxisSpacing: 8.0, // Spacing between columns
                        mainAxisSpacing: 20.0, // Spacing between rows
                      ),
                      itemCount: images.length,
                      itemBuilder: (BuildContext context, int index) {
                        ImageWithText obj = ImageWithText(title: titles[index], image: images[index], onTap: () {}, color: Colors.white, enableHighlight: true, category: category-1, index:index);
                        helper.add(obj);
                        return obj;
                      }
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Button (type: 'Continue', label:'Back', onPressed: () {_hideOverlay(overlayEntry);},)
                ),
              ],
            )
          ) 
        )
      );
    });
    
    overlayState.insertAll([overlayEntry]); 

  }

  Future<void> takingdata(List<ImageWithText>? helper) async {
    //The list which will keep the data
    List<String> keeper;
    keeper = [];

    if(helper != null){
      //traversing and checking, if isHighlighted is true then it is selected
      for (ImageWithText widget in helper) {
        if(widget.isHighlighted){
          keeper.add(widget.title);
        }
      }
    }

    //keeper->list which contains the choices of the user, use this data for web scraping
    CollectionReference recipes = FirebaseFirestore.instance.collection('recipes');
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('food').get();
    String uid = FirebaseAuth.instance.currentUser!.uid;
    for(String titling in keeper){
      for (QueryDocumentSnapshot document in querySnapshot.docs) {
        //checking which recipes have the same title as thos the user selected
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        if(data['title'].contains(titling)){
          await recipes.doc().set({
          'image': data['image'],
          'link': data['link'],
          'review': 0,
          'title': data['title'],
          'user_id': uid
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<ImageWithText> helper = [];

    return Scaffold(  
      extendBodyBehindAppBar: true,
      
      backgroundColor: Colors.transparent,
      body: FutureBuilder(
        future: null,
        builder: (context, snapshot) {
          return Center(
            child: 
              Stack(
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
                child: Button (type: 'Continue', label:'Continue', onPressed: () async {
                  await takingdata(helper);
                  Navigator.pushNamed(context, homeRoute);
                })
              ), 
              Positioned(
                bottom: 300,
                child: Container(
                  height: 130.0,
                  width: 353.0, 
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      ImageWithText(title:'Japanese', image: "https://media.istockphoto.com/id/533713646/photo/close-up-of-sashimi-sushi-set-with-chopsticks-and-soy.jpg?s=612x612&w=0&k=20&c=29ESG2HI79aNASIHBJJR3EO_Xx2Z8YvNhTn17z3lqPk=", isHighlighted: false, onTap: () {_showOverlay(context, 1, helper);}), 
                      ImageWithText(title:'Indian', image: "https://media.istockphoto.com/id/177043240/photo/indian-butter-chicken-curry.jpg?s=612x612&w=0&k=20&c=GnqnIWq99zDdjmOWQg0L7p3eKJTQO_bxnJTVbf8PlpM=", isHighlighted: false, onTap: () {_showOverlay(context, 2, helper);}),
                      ImageWithText(title:'Dessert', image: "https://media.istockphoto.com/id/515447912/photo/blueberry-cheesecake.jpg?s=612x612&w=0&k=20&c=y8Z7no2SEd_oKu9Ocv9uzw9i7fxc8Luy_alnNn5epqQ=", isHighlighted: false, onTap: () {_showOverlay(context, 3, helper);}),
                      ImageWithText(title:'Mexican', image: "https://media.istockphoto.com/id/1347087219/photo/assortment-of-delicious-authentic-tacos-birria-carne-asada-adobada-cabeza-and-chicharone.jpg?s=612x612&w=0&k=20&c=8TJspKsshMc6QN8aBgnbaMgMwKKHZuLKRq8D_BYj5Tw=", isHighlighted: false, onTap: () {_showOverlay(context, 4, helper);}),
                      ImageWithText(title:'Greek', image: "https://media.istockphoto.com/id/465142168/photo/feta-cheese-with-olives.jpg?s=612x612&w=0&k=20&c=b7bYvSBIGP0LH0PpcKZQdpiwmPpU3tYiqIYy5jyatLc=", isHighlighted: false, onTap: () {_showOverlay(context, 5, helper);}),
                      ImageWithText(title:'Other', image: "https://media.istockphoto.com/id/516329534/photo/last-straw.jpg?s=612x612&w=0&k=20&c=q9tScD01SPtN5QNAYgWG-ot4n_4hZXOgMStuFgmBFa8=", isHighlighted: false, onTap: () {_showOverlay(context, 6, helper);}),
                    ]
                  )
                )
              )
            ]  
          ),
          );   
        }
      ),
    );
  }
}