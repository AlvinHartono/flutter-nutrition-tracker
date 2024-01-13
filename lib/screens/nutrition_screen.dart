import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_nutrition_tracker/models/dummy_data.dart';
import 'package:flutter_nutrition_tracker/screens/add_nutritioin_screen.dart';
import 'package:flutter_nutrition_tracker/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:flutter_nutrition_tracker/widgets/food_card.dart';

class AllNutrition extends StatefulWidget {
  const AllNutrition({super.key});

  @override
  State<AllNutrition> createState() => _AllNutritionState();
}

class _AllNutritionState extends State<AllNutrition> {
  final List<FoodCard> _listCard = dummyData;

  final User? user = FirebaseAuthService().currentUser;

  Future<void> signOut() async {
    await FirebaseAuthService().signOut();
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
              child: const Center(
                child: Text('Add something like charts etc'),
              ),
            ),
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
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 5.0,
                ),
                itemCount: _listCard.length,
                itemBuilder: (context, index) {
                  return _listCard[index];
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const AddNutrition(),
          ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
