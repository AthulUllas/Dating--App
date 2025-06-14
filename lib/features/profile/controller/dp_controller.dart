import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';

final dpStorage = GetStorage('dp');

class DpValueNotifier extends StateNotifier<String> {
  DpValueNotifier() : super(dpStorage.read('dp'));

  void updateDp(String newDp) {
    state = newDp;
    dpStorage.write('dp', newDp);
  }
}

final dpProvider = StateNotifierProvider<DpValueNotifier, String>((ref) {
  return DpValueNotifier();
});
