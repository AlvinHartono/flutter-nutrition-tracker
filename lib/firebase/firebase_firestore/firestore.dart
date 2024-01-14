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
    DocumentReference documentRef = _db.collection(userId).doc("2024-01-15");
    DocumentSnapshot documentSnapshot = await documentRef.get();

    Map<String, dynamic> existingData =
        documentSnapshot.data() as Map<String, dynamic>;

    existingData[DateTime.now().toString()] = foodJSON;
    if (user != null) {
      await documentRef.set(
        existingData,
      );
    }
  }

  Future<List<Food>> getDocument(String date) async {
    //
    try {
      QuerySnapshot querySnapshot = await _db.collection(userId).get();
      List<Food> foods = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Food.fromJson(data);
      }).toList();
      return foods;
    } catch (error) {
      print('Error fetching list: $error');
      return [];
    }
  }
}
