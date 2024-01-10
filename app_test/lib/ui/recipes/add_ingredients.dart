import 'package:app_test/app/buttons.dart';
import 'package:app_test/routes/router_constants.dart';
import 'package:flutter/material.dart';
import 'package:app_test/app/colors.dart';
import 'package:app_test/ui/home/menu.dart';
import 'package:app_test/app/text_field.dart';

class AddIngredients extends StatefulWidget {
  const AddIngredients({super.key});

  @override
  State<AddIngredients> createState() => _AddIngredientsState();
}

class _AddIngredientsState extends State<AddIngredients> {


  List<TextEditingController> textControllers = [];
  FocusNode? textFieldFocusNode;

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
                      children: List.generate(textControllers.length, (index) {
                        return Container(
                          padding: const EdgeInsets.all(8),
                          child: CustomTextField(
                            controller: textControllers[index],
                            focusNode: index == textControllers.length - 1
                                        ? textFieldFocusNode 
                                        : null,
                            
                          ),
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
                          textControllers.add(TextEditingController());
                          textFieldFocusNode = FocusNode();
                        });}),
                      const SizedBox(width: 34),
                      Button(type: 'Speak', label: 'Speak', onPressed: () {
                        setState(() {
                          textControllers.add(TextEditingController());
                          textFieldFocusNode = null;
                        });
                      }),
                    ])
                ),
                const SizedBox(height: 50),
                Center (
                  child: Button(type: 'Find', label: 'Find Recipes', onPressed: () {Navigator.pushNamed(context, recipesRoute);})
                )
              ],
            ),
          )
        ],
      )
    );
  }
}