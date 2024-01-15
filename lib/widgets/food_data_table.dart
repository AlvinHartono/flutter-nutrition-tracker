import 'package:flutter/material.dart';
import 'package:flutter_nutrition_tracker/models/food.dart';

class FoodDataTable extends StatelessWidget {
  final List<Food> food;

  const FoodDataTable({required this.food});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const [
        DataColumn(label: Text('Name')),
        DataColumn(label: Text('Calories')),
        DataColumn(label: Text('Serving Size (g)')),
        DataColumn(label: Text('Total Fat (g)')),
        DataColumn(label: Text('Saturated Fat (g)')),
        DataColumn(label: Text('Protein (g)')),
        DataColumn(label: Text('Sodium (mg)')),
        DataColumn(label: Text('Potassium (mg)')),
        DataColumn(label: Text('Cholesterol (mg)')),
        DataColumn(label: Text('Total Carbohydrates (g)')),
        DataColumn(label: Text('Fiber (g)')),
        DataColumn(label: Text('Sugar (g)')),
      ],
      rows: food.map((food) {
        return DataRow(
          cells: [
            DataCell(Text(food.name)),
            DataCell(Text(food.calories.toString())),
            DataCell(Text(food.servingSizeG.toString())),
            DataCell(Text(food.fatTotalG.toString())),
            DataCell(Text(food.fatSaturatedG.toString())),
            DataCell(Text(food.proteinG.toString())),
            DataCell(Text(food.sodiumMg.toString())),
            DataCell(Text(food.potassiumMg.toString())),
            DataCell(Text(food.cholesterolMg.toString())),
            DataCell(Text(food.carbohydratesTotalG.toString())),
            DataCell(Text(food.fiberG.toString())),
            DataCell(Text(food.sugarG.toString())),
          ],
        );
      }).toList(),
    );
  }
}
