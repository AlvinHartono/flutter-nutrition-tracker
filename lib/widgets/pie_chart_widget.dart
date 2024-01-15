import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nutrition_tracker/models/food.dart';

class PieChartWidget extends StatefulWidget {
  const PieChartWidget({
    super.key,
    required this.listOfFood,
    required this.title,
    required this.totalValue,
  });

  final List<Food> listOfFood;
  final String title;
  final double totalValue;

  @override
  State<PieChartWidget> createState() => _PieChartWidgetState();
}

class _PieChartWidgetState extends State<PieChartWidget> {
  final List<Color> predefinedColors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.pink,
    Colors.indigo,
    Colors.brown,
  ];

  @override
  void initState() {
    super.initState();
  }

  double _typeOfData({
    required String title,
    required Food food,
  }) {
    if (title == "Calories") {
      return food.calories;
    } else if (title == "Protein") {
      return food.proteinG;
    } else if (title == "Carbs") {
      return food.carbohydratesTotalG;
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<PieChartSectionData> sections = [];
    String doubleData = widget.totalValue.toStringAsFixed(2);
    for (int i = 0; i < widget.listOfFood.length; i++) {
      Food food = widget.listOfFood[i];
      sections.add(
        PieChartSectionData(
          value: _typeOfData(title: widget.title, food: food),
          color: predefinedColors[i % predefinedColors.length],
          showTitle: true,
          title:
              "${(_typeOfData(title: widget.title, food: food) / widget.totalValue * 100).toStringAsFixed(2)}%",
        ),
      );
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        Text(
          "${widget.title}\n $doubleData",
          style: const TextStyle(
            fontSize: 30,
          ),
        ),
        sections.isNotEmpty &&
                sections.map((e) => e.value).reduce((a, b) => a + b) != 0
            ? PieChart(
                swapAnimationDuration: const Duration(milliseconds: 750),
                swapAnimationCurve: Curves.easeInOutQuint,
                PieChartData(
                  sections: sections,
                  pieTouchData: PieTouchData(
                    touchCallback: (p0, p1) {},
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}
