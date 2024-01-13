import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_nutrition_tracker/user_auth/firebase_auth_implementation/firebase_auth_services.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final User? user = FirebaseAuthService().currentUser;

  Future<void> signOut() async {
    await FirebaseAuthService().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nutrition Tracker"),
      ),
      body: Center(
        child: Column(
          children: [
            Text(user?.email ?? 'user email'),
            ElevatedButton(
              onPressed: signOut,
              child: const Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
