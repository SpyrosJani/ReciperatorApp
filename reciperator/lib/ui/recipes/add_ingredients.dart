import 'package:reciperator/app/buttons.dart';
import 'package:reciperator/routes/router_constants.dart';
import 'package:flutter/material.dart';
import 'package:reciperator/app/colors.dart';
import 'package:reciperator/ui/home/menu.dart';
import 'package:reciperator/app/text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddIngredients extends StatefulWidget {
  const AddIngredients({super.key});

  @override
  State<AddIngredients> createState() => _AddIngredientsState();
}

class _AddIngredientsState extends State<AddIngredients> {

  List<TextEditingController>? textControllers = [];
  FocusNode? textFieldFocusNode;

  List<CustomTextField>? globaller = [];
  CustomTextField adding(int index) {
    CustomTextField aux = CustomTextField(
                            controller: textControllers![index],
                            focusNode: index == textControllers!.length - 1 ? textFieldFocusNode : null,
                            deleted: false,
                          );
    globaller!.add(aux);
    return aux;
  }

  //here happens the search-web scraping
  Future<List<QueryDocumentSnapshot>?> webscraping(List<String> ingredients) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('food').get();
    Map<QueryDocumentSnapshot, int> choosingelements = {};
    for (QueryDocumentSnapshot document in querySnapshot.docs) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      choosingelements[document] = 0;
      for(String titling in ingredients){
        //checking which recipes have the same title as thos the user selected 
        if((data['ingredients'].toLowerCase()).contains(titling.toLowerCase())){
          choosingelements[document] = (choosingelements[document] ?? 0) + 1;
        }
      }
    }

    //Take the 5 closest
    List<QueryDocumentSnapshot> sortedKeys = choosingelements.keys.toList()
    ..sort((a, b) => choosingelements[b]!.compareTo(choosingelements[a]!));

    // Get the top 5 keys
    List<QueryDocumentSnapshot> top5Keys = sortedKeys.take(5).toList();
  
    return top5Keys;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: AppColors.green,
        elevation: 0,
      ), 
      //backgroundColor: Colors.transparent,
      drawer: const Menu(), 
      body: FutureBuilder(
        future: null,
        builder: (context, snapshot){
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
              Positioned(
                top: 105,
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 80,
                      child: const Text(
                        'Insert your available ingredients!',
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 26, 
                          fontStyle: FontStyle.italic,
                          color: Colors.black,
                        ),
                      )
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 330,
                      height: 231,
                      child: SingleChildScrollView(
                        child: Column(
                          children: List.generate(textControllers!.length, (index)  {
                            return Container(
                              padding: const EdgeInsets.all(8),
                              child: adding(index),
                            );
                          }),
                        ),
                      ),
                    ),
                    const SizedBox(height: 70),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Button(type: 'Write', label: 'Write', onPressed: () { 
                            setState(() {
                              textControllers!.add(TextEditingController());
                              textFieldFocusNode = FocusNode();
                            });}),
                          const SizedBox(width: 34),
                          Button(type: 'Speak', label: 'Speak', onPressed: () {
                            setState(() {
                              textControllers!.add(TextEditingController());
                              textFieldFocusNode = null;
                            });
                          }),
                        ])
                    ),
                    const SizedBox(height: 50),
                    Center (
                      child: Button(type: 'Find', label: 'Find Recipes', onPressed: () async {
                        //Taking the non deleted fields
                        List<String> tosearch = [];
                        int count = 0;
                        int lowerlimit = 0;
                        for(CustomTextField i in globaller!){
                            if(lowerlimit < globaller!.length-textControllers!.length){
                              lowerlimit++;
                              count++;
                              continue;
                            }
                            else if(lowerlimit == globaller!.length-textControllers!.length){
                              count = 0;
                              lowerlimit++;
                            }
                            if(!i.deleted){
                              tosearch.add(textControllers![count].text);
                            }
                            count ++;
                        }

                        //Clearing the empty strings
                        count = 0;
                        for(String s in tosearch){
                          if(s.isEmpty){
                            tosearch.removeAt(count);
                          }
                          count++;
                        }

                        //Checking if the user gave ingredients
                        if(tosearch.isEmpty){
                          showDialog(
                            context: context, 
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Add Ingredients!", style:TextStyle(color: Colors.white)), 
                                content: const Text("You didn't add any ingredients!", style:TextStyle(color: Colors.white)),
                                backgroundColor: AppColors.promptBackground,
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context, 'OK'),
                                    child: const Text('Got It!'))
                                ]
                              );
                            }
                          );
                        }
                        else{
                          List<QueryDocumentSnapshot>? results = await webscraping(tosearch);
                          textControllers!.clear();
                          globaller!.clear();
                          Navigator.pushReplacementNamed(context, recipesRoute ,arguments: results);
                        }
                      })
                    )
                  ],
                ),
              )
            ],
          );
        }
      ),
    );
  }
}