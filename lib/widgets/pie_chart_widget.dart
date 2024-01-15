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
  Color getRandomColor() {
    return Color.fromARGB(
      255,
      Random().nextInt(256),
      Random().nextInt(256),
      Random().nextInt(256),
    );
  }

  double _typeOfData({
    required String title,
    required Food food,
  }) {
    if (title == "Calories") {
      return food.calories;
    } else if (title == "protein") {
      return food.calories;
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<PieChartSectionData> sections = [];
    for (Food food in widget.listOfFood) {
      sections.add(
        PieChartSectionData(
          value: _typeOfData(title: widget.title, food: food),
          color: getRandomColor(),
          showTitle: false,
        ),
      );
    }

    String doubleData = widget.totalValue.toStringAsFixed(2);

    return Stack(
      alignment: Alignment.center,
      children: [
        Text(
          doubleData,
        ),
        PieChart(
          swapAnimationDuration: const Duration(milliseconds: 750),
          swapAnimationCurve: Curves.easeInOutQuint,
          PieChartData(
            sections: sections,
            pieTouchData: PieTouchData(
              touchCallback: (p0, p1) {},
            ),
          ),
        ),
      ],
    );
  }
}
