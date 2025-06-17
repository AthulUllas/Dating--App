import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/features/home/service/database_service.dart';
import 'package:matrimony/features/profile/helper/connectivity_check_helper.dart';
import 'package:matrimony/features/userdetails/services/getstorage_service.dart';

final databaseFieldServices = DatabaseFieldServices();
final uid = FirebaseAuth.instance.currentUser?.uid;

class PhoneValueNotifier extends StateNotifier<String?> {
  PhoneValueNotifier() : super(null) {
    loadPhone();
  }

  Future<void> loadPhone() async {
    final isInternetAvailable = await checkConnectivity();
    if (isInternetAvailable) {
      final phone = await databaseFieldServices.getUserField(uid!, 'phone');
      state = phone;
    } else {
      final phone = phoneStorage.read('phone');
      state = phone;
    }
  }

  Future<void> refresh() async {
    await loadPhone();
  }
}

final phoneController = StateNotifierProvider<PhoneValueNotifier, String?>((
  ref,
) {
  return PhoneValueNotifier();
});
