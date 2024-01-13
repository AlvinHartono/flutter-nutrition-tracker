import 'package:flutter/material.dart';
import 'package:flutter_nutrition_tracker/models/dummy_data.dart';
import 'package:flutter_nutrition_tracker/widgets/food_card.dart';
import 'package:table_calendar/table_calendar.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  DateTime today = DateTime.now();
  DateTime? _selectedDay;
  //List<FoodCard> selectedFoodList = [];
  //Map<DateTime, List<FoodCard>> event = {};
  //final List<FoodCard> _listEventCard = dummyData;

  @override
  void initState() {
    super.initState();
    // Populate event map with dummy data for today
    today = DateTime.now();
    // event[today] = _listEventCard;

    // if (event.containsKey(today)) {
    //   selectedFoodList = event[today]!;
    // }
  }

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
      _selectedDay = focusedDay;
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
        ],
      ),
    );
  }
}
