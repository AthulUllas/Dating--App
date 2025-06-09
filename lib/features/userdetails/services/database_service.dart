import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class DatabaseFieldServices {
  Future<String?> getUserName(String uid) async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get();
      if (doc.exists) {
        String name = doc['name'];
        return name;
      } else {
        debugPrint(
          "<___________----------------------Doc don't exist----------------------___________________>",
        );
        return null;
      }
    } catch (e) {
      debugPrint("Error getting the name");
      return null;
    }
  }

  Future<String?> getPhoneNumber(String uid) async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get();
      if (doc.exists) {
        String phone = doc['phone'];
        return phone;
      } else {
        debugPrint(
          "<___________----------------------Doc don't exist----------------------____________>",
        );
        return null;
      }
    } catch (e) {
      debugPrint("Error getting the name");
      return null;
    }
  }
}
