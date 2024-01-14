import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_nutrition_tracker/firebase/firebase_firestore/firestore.dart';
import 'package:flutter_nutrition_tracker/models/food.dart';
import 'package:flutter_nutrition_tracker/screens/add_nutritioin_screen.dart';
import 'package:flutter_nutrition_tracker/firebase/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:flutter_nutrition_tracker/widgets/food_card.dart';
import 'package:flutter_nutrition_tracker/widgets/pie_chart_widget.dart';

class AllNutrition extends StatefulWidget {
  const AllNutrition({super.key});

  @override
  State<AllNutrition> createState() => _AllNutritionState();
}

class _AllNutritionState extends State<AllNutrition> {
  FirebaseFirestoreHelper database = FirebaseFirestoreHelper();
  final User? user = FirebaseAuthService().currentUser;

  List<Food> _foodList = [];

  Future<void> fetchTodaysFood() async {
    List<Food> foods = await database.getDocument("2024-01-14");
    setState(() {
      _foodList = foods;
    });
    print("actual food list: " + _foodList.toString());
    print("fetched food list: " + foods.toString());
  }

  Future<void> signOut() async {
    await FirebaseAuthService().signOut();
  }

  void _addFood(Food food) {
    setState(() {
      _foodList.add(food);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchTodaysFood();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.green,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    "Welcome,",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    user?.email ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: ListTile(
                tileColor: Colors.red,
                title: const Text("Sign Out"),
                onTap: signOut,
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text("Nutrition Tracker"),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Column(
          children: [
            Container(
                width: double.infinity,
                height: 250,
                color: Colors.red,
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      color: Colors.black12,
                      width: 200,
                      height: 200,
                      child: PieChartWidget(
                        listOfFood: _foodList,
                        title: "Calories",
                      ),
                    ),
                  ],
                )),
            const SizedBox(
              height: 14,
            ),
            const Text(
              "Today's nutrtion",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            const SizedBox(
              height: 14,
            ),
            Expanded(
              child: _foodList.isEmpty
                  ? const Center(
                      child: Text("No data"),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 5.0,
                      ),
                      itemCount: _foodList.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          background: Container(
                            color: Colors.redAccent,
                            child: const Icon(Icons.delete),
                          ),
                          key: ValueKey(
                            _foodList[index],
                          ),
                          onDismissed: (direction) {
                            print('yo');
                            setState(() {
                              _foodList.removeAt(index);
                            });
                          },
                          child: FoodCard(
                            food: _foodList[index],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var newData = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddNutrition(),
            ),
          );
          if (newData != null) {
            _addFood(newData);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
