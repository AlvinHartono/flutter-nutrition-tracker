import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_nutrition_tracker/screens/add_nutritioin_screen.dart';
import 'package:flutter_nutrition_tracker/user_auth/firebase_auth_implementation/firebase_auth_services.dart';

class AllNutrition extends StatefulWidget {
  const AllNutrition({super.key});

  @override
  State<AllNutrition> createState() => _AllNutritionState();
}

class _AllNutritionState extends State<AllNutrition> {
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
                )),
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
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [],
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
