import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_nutrition_tracker/config/config.dart';
import 'package:flutter_nutrition_tracker/firebase/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:flutter_nutrition_tracker/firebase/firebase_firestore/firestore.dart';
import 'package:flutter_nutrition_tracker/models/food.dart';
import 'package:http/http.dart' as http;

class AddNutrition extends StatefulWidget {
  const AddNutrition({super.key});

  @override
  State<AddNutrition> createState() => _AddNutritionState();
}

class _AddNutritionState extends State<AddNutrition> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _foodName = TextEditingController();
  final TextEditingController _quantity = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _foodName.dispose();
    _quantity.dispose();
  }

  bool _isVisible = false;
  bool _isNotFound = false;
  List<Food> _foods = [];
  Map<String, dynamic> _foodJSON = {};
  final FirebaseFirestoreHelper database = FirebaseFirestoreHelper();

  Future<List<Food>> fetchData(
      {required String foodName, required String quantity}) async {
    _foods = <Food>[];
    String foodQuery = "${quantity}g $foodName";
    String url = 'https://api.api-ninjas.com/v1/nutrition?query=$foodQuery';
    //
    var response = await http
        .get(Uri.parse(url), headers: {'X-Api-Key': AppConfig.apiKey});

    var foods = <Food>[];

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      _foodJSON = jsonList[0];

      setState(() {
        for (var foodsJson in jsonList) {
          _isNotFound = false;
          if (jsonList.isNotEmpty) {
            foods.add(Food.fromJson(foodsJson));
          }
        }
      });
    } else {
      throw Exception('Failed to load data');
    }
    return foods;
  }

  Future<void> _sendFoodToDatabase() async {
    String? userId = FirebaseAuthService().currentUser?.uid;
    if (userId != '') {}
    FirebaseFirestoreHelper()
        .createFields(FirebaseFirestoreHelper().userId, _foodJSON);
  }

  //
  void _searchButtonPressed() async {
    setState(() {
      _isVisible = true;
    });

    try {
      _foods =
          await fetchData(foodName: _foodName.text, quantity: _quantity.text);
      if (_foods.isEmpty) {
        setState(() {
          _isNotFound = true;
        });
      }
    } catch (error) {
      print('Error fetching data: $error');
      setState(() {
        _isVisible = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Nutrition'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                Container(
                  width: screenWidth,
                  height: screenheight * 0.2,
                  // color: Colors.red,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        // color: Colors.yellow,
                        height: 150,
                        width: 300,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _foodName,
                              decoration: const InputDecoration(
                                labelText: "Food Name",
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please enter a food name';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: _quantity,
                              decoration: const InputDecoration(
                                labelText: "quantity (in grams)",
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please enter a food name';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _searchButtonPressed,
                        child: const Text("Search"),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: _isVisible,
                  child: _buildResultWidget(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildText(String variable, String data) {
    return Text('$variable : $data');
  }

  Widget _buildResultWidget() {
    if (_isNotFound) {
      return const Text("Nutrition Data is not found, try another food name");
    } else if (_foods.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildText('Name', _foods[0].name),
              _buildText('Calories', _foods[0].calories.toString()),
              _buildText('Serving Size (g)', _foods[0].servingSizeG.toString()),
              _buildText('Total Fat (g)', _foods[0].fatTotalG.toString()),
              _buildText(
                  'Saturated Fat (g)', _foods[0].fatSaturatedG.toString()),
              _buildText('Protein (g)', _foods[0].proteinG.toString()),
              _buildText('Sodium (mg)', _foods[0].sodiumMg.toString()),
              _buildText('Potassium (mg)', _foods[0].potassiumMg.toString()),
              _buildText(
                  'Cholesterol (mg)', _foods[0].cholesterolMg.toString()),
              _buildText('Total Carbohydrates (g)',
                  _foods[0].carbohydratesTotalG.toString()),
              _buildText('Fiber (g)', _foods[0].fiberG.toString()),
              _buildText('Sugar (g)', _foods[0].sugarG.toString()),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Center(
            child: ElevatedButton.icon(
              onPressed: () {
                final Food food = Food(
                    name: _foods[0].name,
                    calories: _foods[0].calories,
                    servingSizeG: _foods[0].servingSizeG,
                    fatTotalG: _foods[0].fatTotalG,
                    fatSaturatedG: _foods[0].fatSaturatedG,
                    proteinG: _foods[0].proteinG,
                    sodiumMg: _foods[0].sodiumMg,
                    potassiumMg: _foods[0].potassiumMg,
                    cholesterolMg: _foods[0].cholesterolMg,
                    carbohydratesTotalG: _foods[0].carbohydratesTotalG,
                    fiberG: _foods[0].fiberG,
                    sugarG: _foods[0].sugarG);

                _sendFoodToDatabase();

                Navigator.of(context).pop(
                  food,
                );
              },
              icon: const Icon(Icons.add),
              label: Text("add ${_foods[0].name}"),
            ),
          ),
        ],
      );
    }
  }
}
