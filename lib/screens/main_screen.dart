import 'package:flutter/material.dart';
import 'package:flutter_nutrition_tracker/firebase/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:flutter_nutrition_tracker/firebase/firebase_firestore/firestore.dart';
import 'package:flutter_nutrition_tracker/screens/history_nutrition_screen.dart';
import 'package:flutter_nutrition_tracker/screens/nutrition_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  FirebaseFirestoreHelper database = FirebaseFirestoreHelper();

  @override
  void initState() {
    super.initState();
    // print(FirebaseAuthService().currentUser?.uid);
    // database.createCollection(FirebaseAuthService().currentUser?.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        shadowColor: Colors.black,
        backgroundColor: Colors.white,
        onDestinationSelected: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        selectedIndex: _currentIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.history_outlined),
            label: 'History',
          ),
        ],
      ),
      body: [
        const AllNutrition(),
        const History(),
      ][_currentIndex],
    );
  }
}
