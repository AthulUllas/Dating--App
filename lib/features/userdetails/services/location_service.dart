import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:matrimony/utils/snackbar.dart';

Future<String> getCurrentLocation(BuildContext context) async {
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

  try {
    final currentPosition = await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(accuracy: LocationAccuracy.best),
    );

    debugPrint(
      "Lat --- ${currentPosition.latitude} , Long --- ${currentPosition.longitude}",
    );
    final location = await getAddressFromLatlng(currentPosition);
    return location;
  } catch (e) {
    debugPrint(e.toString());
    return e.toString();
  }
}

Future<String> getAddressFromLatlng(Position position) async {
  try {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    final placemark = placemarks.first;
    final address =
        "PinCode = ${placemark.postalCode}, Place = ${placemark.locality}, PlusCode = ${placemark.name}";
    debugPrint(address);
    return address;
  } catch (e) {
    debugPrint(
      "<---------------------------------------------${e.toString()}------------------------------------------------------->",
    );
    return e.toString();
  }
}
