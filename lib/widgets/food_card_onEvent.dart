import 'package:flutter/material.dart';
import 'package:flutter_nutrition_tracker/models/food.dart';

class FoodCardOnEvent extends StatelessWidget {
  const FoodCardOnEvent(
      {super.key,
      required this.food,
      required this.totalCalories,
      required this.totalCarbs,
      required this.totalProtein});
  final Food food;

  final double totalCalories;
  final double totalProtein;
  final double totalCarbs;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0.5),
        child: Card(
          margin: const EdgeInsets.all(16.0),
          color: Colors.white,
          elevation: 2.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildNutritionInformation(
                  label: "Total Calories \t",
                  value: totalCalories.toStringAsFixed(2)),
              _buildNutritionInformation(
                  label: "Total Protein \t",
                  value: totalProtein.toStringAsFixed(2)),
              _buildNutritionInformation(
                  label: "Total Carbs \t",
                  value: totalCarbs.toStringAsFixed(2)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNutritionInformation(
      {required String label, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.right,
        )
      ],
    );
  }
}
