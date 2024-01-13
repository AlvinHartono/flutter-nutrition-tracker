import 'package:flutter/material.dart';
import 'package:flutter_nutrition_tracker/models/food.dart';

class FoodCard extends StatelessWidget {
  const FoodCard({super.key, required this.food});
  final Food food;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 100,
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Row(
          children: [
            Text(food.name),
          ],
        ),
      ),
    );
  }
}
