import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class DatabaseFieldServices {
  Future<List<Map<String, dynamic>>> getGenderSpecifiedUsers(
    String gender,
    String currentUserId,
  ) async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('gender', isEqualTo: gender)
          .get(GetOptions(source: Source.server));

      final nameAndPhone = snapshot.docs
          .map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return {
              'uid': doc.id,
              'name': data['name'],
              'phone': data['phone'],
            };
          })
          .where((user) => user['uid'] != currentUserId)
          .toList();

      return nameAndPhone;
    } catch (e) {
      debugPrint(
        "Error fetching $gender users: --------------$e--------------",
      );
      return [];
    }
  }

  Future<String?> getUserField(String uid, String field) async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get();
      if (doc.exists) {
        String fieldData = doc[field];
        return fieldData;
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
