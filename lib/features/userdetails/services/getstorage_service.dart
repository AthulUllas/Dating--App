import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

final nameStorage = GetStorage('name');
final phoneStorage = GetStorage('phone');
final genderStorage = GetStorage('gender');
final dpStorage = GetStorage('dp');
final locationStorage = GetStorage('location');
final locationPlusCodeStorage = GetStorage('locationpluscode');

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

void saveDp(String dp) {
  dpStorage.write('dp', dp);
  debugPrint(dpStorage.read('dp'));
}

void saveLocation(String place) {
  locationStorage.write('place', place);
  debugPrint(locationStorage.read('place'));
}

void saveLocationPlusCode(String plusCode) {
  locationPlusCodeStorage.write('pluscode', plusCode);
  debugPrint(locationPlusCodeStorage.read('pluscode'));
}
