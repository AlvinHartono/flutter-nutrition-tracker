import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_nutrition_tracker/firebase/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:flutter_nutrition_tracker/models/food.dart';

class FirebaseFirestoreHelper {
  //Initialize firestore
  String userId = FirebaseAuthService().currentUser?.uid ?? "";
  User? user = FirebaseAuthService().currentUser;
  final _db = FirebaseFirestore.instance;
  String currentDate = DateTime.now().toString();

  Future<void> createFields(String? id, Map<String, dynamic> foodJSON) async {
    try {
      //
      final foodref = _db.collection(userId).doc("2024-01-14");
      DocumentSnapshot doc = await foodref.get();
      Map<String, dynamic> foodData = {};

      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        foodData = data;
        foodData[currentDate] = foodJSON;
        await foodref.set(foodData);
      } else {
        foodData[currentDate] = foodJSON;
        await foodref.set(foodData);
      }
    } catch (error) {
      print('ERROR CREATING FIELDS: $error');
    }
  }

  Future<List<Food>> getDocument(String date) async {
    //
    try {
      final foodRef = _db.collection(userId).doc(date);
      DocumentSnapshot doc = await foodRef.get();

      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        List<Food> foodList = [];
        print(data.toString());

        data.forEach((timestamp, foodJSON) {
          Food food = Food.fromJson(foodJSON);
          foodList.add(food);
        });

        return foodList;
      }
    } catch (error) {
      print('Error fetching list: $error');
    }
    return [];
  }
}
