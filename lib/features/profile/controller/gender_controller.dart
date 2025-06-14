import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/features/home/service/database_service.dart';
import 'package:matrimony/features/profile/helper/connectivity_check_helper.dart';
import 'package:matrimony/features/userdetails/services/getstorage_service.dart';

final databaseFieldServices = DatabaseFieldServices();
final uid = FirebaseAuth.instance.currentUser?.uid;

class GenderValueNotifier extends StateNotifier<String?> {
  GenderValueNotifier() : super(null) {
    loadGender();
  }

  Future<void> loadGender() async {
    final isInternetAvailable = await checkConnectivity();
    if (isInternetAvailable) {
      final name = await databaseFieldServices.getUserField(uid!, 'gender');
      state = name;
    } else {
      final name = genderStorage.read('gender');
      state = name;
    }
  }

  Future<void> refresh() async {
    await loadGender();
  }
}

final genderController = StateNotifierProvider<GenderValueNotifier, String?>((
  ref,
) {
  return GenderValueNotifier();
});
