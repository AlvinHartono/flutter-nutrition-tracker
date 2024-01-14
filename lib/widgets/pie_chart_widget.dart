import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nutrition_tracker/models/food.dart';

class PieChartWidget extends StatefulWidget {
  const PieChartWidget({
    super.key,
    required this.listOfFood,
    required this.title,
  });

  final List<Food> listOfFood;
  final String title;

  @override
  State<PieChartWidget> createState() => _PieChartWidgetState();
}

class _PieChartWidgetState extends State<PieChartWidget> {
  double totalValue = 0.0;
  Color getRandomColor() {
    return Color.fromARGB(
      255,
      Random().nextInt(256),
      Random().nextInt(256),
      Random().nextInt(256),
    );
  }

  @override
  Widget build(BuildContext context) {
    for (Food food in widget.listOfFood) {
      setState(() {
        totalValue += food.calories;
      });
    }
    List<PieChartSectionData> sections = [];
    for (Food food in widget.listOfFood) {
      sections.add(
        PieChartSectionData(
          value: food.calories,
          color: getRandomColor(),
          showTitle: false,
        ),
      );
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        Text(
          totalValue.toString(),
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
