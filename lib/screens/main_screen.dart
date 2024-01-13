import 'package:flutter/material.dart';
import 'package:flutter_nutrition_tracker/screens/add_nutrtion_screen.dart';
import 'package:flutter_nutrition_tracker/screens/nutrition_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
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
            icon: Icon(Icons.add),
            label: 'Add Nutrtion',
          ),
        ],
      ),
      body: [
        const AllNutrition(),
        const AddNutrtion(),
      ][_currentIndex],
    );
  }
}
