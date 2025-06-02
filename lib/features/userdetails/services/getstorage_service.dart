import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

final nameStorage = GetStorage('name');
final phoneStorage = GetStorage('phone');
final genderStorage = GetStorage('gender');

void saveDetails(String name, String phone) {
  nameStorage.write('name', name);
  phoneStorage.write('phone', phone);
  debugPrint(nameStorage.read('name'));
  debugPrint(phoneStorage.read('phone'));
}

void saveGender(String? gender) {
  genderStorage.write('gender', gender);
  debugPrint(genderStorage.read('gender'));
}
