import 'package:flutter/material.dart';

class AddNutrtion extends StatefulWidget {
  const AddNutrtion({super.key});

  @override
  State<AddNutrtion> createState() => _AddNutrtionState();
}

class _AddNutrtionState extends State<AddNutrtion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add Food"),
          centerTitle: true,
        ),
        body: Center(
          child: Text("Add Food Screen"),
        ));
  }
}
