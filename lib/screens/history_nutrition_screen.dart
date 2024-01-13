import 'dart:convert' show jsonDecode;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_nutrition_tracker/models/food.dart';
import 'package:table_calendar/table_calendar.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  DateTime today = DateTime.now();
  DateTime? _selectedDay;
  List<Food> _foodList = <Food>[];
  Map<DateTime, String> foodName = {};
  TextEditingController _foodNameController = TextEditingController();

  //testing by input
  Future<List<Food>> fetchFoods(String foodName) async {
    var apiKey = "7JdkTq3FchntRBv5Ax1Eog==lWifTLw8ivhrr98C";
    var url = 'https://api.api-ninjas.com/v1/nutrition?query=$foodName';
    var response =
        await http.get(Uri.parse(url), headers: {'X-Api-Key': apiKey});

    var foods = <Food>[];

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);

      for (var foodsJson in jsonList) {
        foods.add(Food.fromJson(foodsJson));
      }
    } else {
      throw Exception('Failed to load food nutritions');
    }
    return foods;
  }

  Future<void> _updateFoodData(String foodName) async {
    try {
      var foods = await fetchFoods(foodName);
      setState(() {
        // Store the fetched data in the list
        _foodList = foods;
      });

      // Print the stored data
      _foodList.forEach((food) {
        printFoodDetails(food);
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void printFoodDetails(Food food) {
    print('Name: \t\t ${food.name}');
    print('Calories: \t ${food.calories}');
    print('Serving size (g): \t ${food.servingSizeG}');
    print('Fat Total (g): \t ${food.fatTotalG}');
    print('Sodium (mg): \t\t ${food.sodiumMg}');
    print('Potassium (mg): \t ${food.potassiumMg}');
    print('Cholesterol (mg): \t ${food.cholesterolMg}');
    print('Carbohydrates Total (g): ${food.carbohydratesTotalG}');
    print('Fiber (g): \t\t ${food.fiberG}');
    print('Sugar (g): \t\t ${food.sugarG}');
    // ... print other details ...
    print('-------------------------');
  }
  //here

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Nutrition History"),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    scrollable: true,
                    title: Text("Input food"),
                    content: Padding(
                      padding: EdgeInsets.all(8),
                      child: TextField(
                        controller: _foodNameController,
                      ),
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          _updateFoodData(_foodNameController.text);

                          foodName.addAll(
                              {_selectedDay!: _foodNameController.text});
                          Navigator.of(context).pop();
                        },
                        child: Text("Submit"),
                      )
                    ],
                  );
                });
          },
          child: Icon(Icons.add),
        ),
        body: content());
  }

  Widget content() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            child: TableCalendar(
              locale: "en_US",
              headerStyle: const HeaderStyle(
                  formatButtonVisible: false, titleCentered: true),
              availableGestures: AvailableGestures.all,
              selectedDayPredicate: (day) => isSameDay(day, today),
              firstDay: DateTime.utc(2000, 1, 1),
              lastDay: DateTime.utc(2099, 12, 31),
              focusedDay: today,
              onDaySelected: _onDaySelected,
            ),
          )
        ],
      ),
    );
  }
}
