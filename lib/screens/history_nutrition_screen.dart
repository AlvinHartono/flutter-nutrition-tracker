import 'package:flutter/material.dart';
import 'package:flutter_nutrition_tracker/models/food.dart';
import 'package:flutter_nutrition_tracker/widgets/food_card_onEvent.dart';
import 'package:flutter_nutrition_tracker/widgets/food_data_table.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_nutrition_tracker/firebase/firebase_firestore/firestore.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  DateTime today = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  List<Food> _foodlist = [];
  double totalCalories = 0.0;
  double totalProtein = 0.0;
  double totalCarbs = 0.0;

  FirebaseFirestoreHelper database = FirebaseFirestoreHelper();

  Future<void> fetchSelectedDaysFood(String dateKey) async {
    print(dateKey);
    List<Food> foods = await database.getDocument(dateKey);
    setState(() {
      _foodlist = foods;
      for (Food food in _foodlist) {
        totalCalories += food.calories;
        totalProtein += food.proteinG;
        totalCarbs += food.carbohydratesTotalG;
      }
    });
  }

  String generateDateKey(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  @override
  void initState() {
    super.initState();
    fetchSelectedDaysFood(generateDateKey(_selectedDay));
    today = DateTime.now();
    _selectedDay = today;
  }

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
      _selectedDay = focusedDay;
      totalCalories = 0.0;
      totalProtein = 0.0;
      totalCarbs = 0.0;

      fetchSelectedDaysFood(generateDateKey(_selectedDay));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nutrition History"),
        centerTitle: true,
      ),
      body: content(),
    );
  }

  Widget content() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            child: TableCalendar(
              locale: "en_US",
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              availableGestures: AvailableGestures.all,
              selectedDayPredicate: (day) => isSameDay(day, today),
              firstDay: DateTime.utc(2000, 1, 1),
              lastDay: DateTime.utc(2099, 12, 31),
              focusedDay: today, // Set the initial focused day to today
              onDaySelected: _onDaySelected,
            ),
          ),
          Expanded(
            child: _foodlist.isEmpty
                ? const Center(
                    child: Text("no data"),
                  )
                : Column(
                    children: [
                      const SizedBox(height: 5),
                      SizedBox(
                        height: MediaQuery.of(context).size.height *
                            0.16, // Adjust the height as needed
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5.0,
                                vertical: 2.0,
                              ),
                              child: FoodCardOnEvent(
                                totalCalories: totalCalories,
                                totalCarbs: totalCarbs,
                                totalProtein: totalProtein,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height *
                            0.20, // Adjust the height as needed
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: FoodDataTable(food: _foodlist),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
