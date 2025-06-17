import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/features/userdetails/services/getstorage_service.dart';

class DpValueNotifier extends StateNotifier<String> {
  DpValueNotifier() : super(dpStorage.read('dp'));

  void updateDp(String newDp) {
    state = newDp;
    dpStorage.write('dp', newDp);
  }

  void refresh() {
    state = dpStorage.read('dp');
  }
}

final dpProvider = StateNotifierProvider<DpValueNotifier, String>((ref) {
  return DpValueNotifier();
});
