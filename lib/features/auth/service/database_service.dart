import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DatabaseServices {
  Future<void> registerUserInDatabase(
    String? email,
    BuildContext context,
    String? name,
    String? phone,
    String? gender,
    String? photoUrl,
    String? location,
  ) async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    final model = androidInfo.model;
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        final uid = user.uid;
        FirebaseFirestore.instance.collection('users').doc(uid).set({
          'name': name,
          'email': email,
          'phone': phone,
          'gender': gender,
          'photoUrl': photoUrl,
          'location': location,
          'createdAt': DateTime.now(),
          'devicemodel': model,
        });
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  Future<void> updateUserDetailsInDatabase(
    String name,
    String phone,
    BuildContext context,
    String location,
  ) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        final uid = user.uid;
        FirebaseFirestore.instance.collection('users').doc(uid).update({
          'name': name,
          'phone': phone,
          'location': location,
        });
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  Future<void> updateGenderInDatabase(
    String gender,
    BuildContext context,
  ) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        final uid = user.uid;
        FirebaseFirestore.instance.collection('users').doc(uid).update({
          'gender': gender,
        });
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  Future<void> updateLocationAndDeviceInfoInDatabase(String location) async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    final deviceModel = androidInfo.model;
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        final uid = user.uid;
        FirebaseFirestore.instance.collection('users').doc(uid).update({
          'location': location,
          'devicemodel': deviceModel,
        });
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }
}
