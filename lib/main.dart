import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:matrimony/features/splashscreen/view/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseFirestore.instance.clearPersistence();
  GetStorage.init('name');
  GetStorage.init('phone');
  GetStorage.init('gender');
  GetStorage.init('dp');
  GetStorage.init('location');
  GetStorage.init('locationpluscode');
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyDELHJE4ueIRBlE9u3qdpnJUNUvmoAEWEc",
      appId: "1:97152258989:android:c3ad71cc48c27d5ffe8724",
      messagingSenderId: "97152258989",
      projectId: "matrimony--app",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      title: 'Favmate',
      debugShowCheckedModeBanner: false,
      home: Splashscreen(),
    );
  }
}
