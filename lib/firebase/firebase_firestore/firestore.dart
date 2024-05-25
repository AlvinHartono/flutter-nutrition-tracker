import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_nutrition_tracker/firebase/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:flutter_nutrition_tracker/models/food.dart';

class FirebaseFirestoreHelper {
  //Initialize firestore
  String userId = FirebaseAuthService().currentUser?.uid ?? "";
  User? user = FirebaseAuthService().currentUser;
  final _db = FirebaseFirestore.instance;

  Future<void> createFields(
    String? id,
    Map<String, dynamic> foodJSON,
    String today,
    String currentDate,
  ) async {
    try {
      //
      final foodref = _db.collection(userId).doc(today);
      DocumentSnapshot doc = await foodref.get();

      Map<String, dynamic> foodData = {};

      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        print(data);
        foodData = data;
        foodData[currentDate] = foodJSON;
        print(foodData);

        await foodref.set(foodData);
      } else {
        foodData[today] = foodJSON;
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
        print(data);
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

  Future<List<String>> getFieldKey(String date) async {
    //
    try {
      final foodRef = _db.collection(userId).doc(date);
      DocumentSnapshot doc = await foodRef.get();

      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        List<String> keyList = [];

        data.forEach((timestamp, foodJSON) {
          keyList.add(timestamp);
        });
        print(keyList);

        return keyList;
      }
    } catch (error) {
      print('Error fetching list: $error');
    }
    return [];
  }

  Future<void> deleteFood(String date, String foodKey) async {
    try {
      final foodRef = _db.collection(userId).doc(date);

      // Get the current data
      DocumentSnapshot doc = await foodRef.get();
      if (!doc.exists) {
        print('Document not found');
      }

      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      // Remove the specified food item
      data.remove(foodKey);

      // Update the document without the deleted food item
      await foodRef.set(data);
      print('Food deleted successfully');
    } catch (error) {
      print('Error deleting food: $error');
    }
  }
}
