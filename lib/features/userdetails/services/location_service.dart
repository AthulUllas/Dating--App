import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:matrimony/utils/snackbar.dart';

Future<Position?> getCurrentLocation(BuildContext context) async {
  bool serviceEnabled;
  LocationPermission permission;
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      snackBar("Allow the location service", context, 1, FlashPosition.top);
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        snackBar("Allow for further detailing", context, 1, FlashPosition.top);
      }
    }
  }

  // permission = await Geolocator.checkPermission();
  // if (permission == LocationPermission.denied) {
  //   permission = await Geolocator.requestPermission();
  //   if (permission == LocationPermission.denied) {
  //     return Future.error("Location permission disabled");
  //   }
  // }

  // if (permission == LocationPermission.deniedForever) {
  //   return Future.error('Location permission is denied forever');
  // }
  try {
    final currentPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    debugPrint(
      "Lat --- ${currentPosition.latitude} , Long --- ${currentPosition.longitude}",
    );
    getAddressFromLatlng(currentPosition);
    return currentPosition;
  } catch (e) {
    debugPrint(e.toString());
    return null;
  }
}

Future<String> getAddressFromLatlng(Position position) async {
  List<Placemark> placemarks = await placemarkFromCoordinates(
    position.latitude,
    position.longitude,
  );

  final placemark = placemarks.first;
  final address =
      "PinCode = ${placemark.postalCode}, Place = ${placemark.locality}, PlusCode = ${placemark.name}";
  debugPrint(address);
  return address;
}
