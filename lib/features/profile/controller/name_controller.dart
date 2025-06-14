import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/features/homepage/service/database_service.dart';
import 'package:matrimony/features/profile/helper/connectivity_check_helper.dart';
import 'package:matrimony/features/userdetails/services/getstorage_service.dart';

final databaseFieldServices = DatabaseFieldServices();
final uid = FirebaseAuth.instance.currentUser?.uid;

class NameValueNotifier extends StateNotifier<String?> {
  NameValueNotifier() : super(null) {
    loadName();
  }

  Future<void> loadName() async {
    final isInternetAvailable = await checkConnectivity();
    if (isInternetAvailable) {
      final name = await databaseFieldServices.getUserField(uid!, 'name');
      state = name;
    } else {
      final name = nameStorage.read('name');
      state = name;
    }
  }

  Future<void> refresh() async {
    await loadName();
  }
}

final nameController = StateNotifierProvider<NameValueNotifier, String?>((ref) {
  return NameValueNotifier();
});
