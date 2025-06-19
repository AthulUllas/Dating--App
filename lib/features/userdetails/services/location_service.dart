import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:matrimony/features/userdetails/services/getstorage_service.dart';

Future<String> getCurrentLocation(BuildContext context) async {
  bool isServiceEnabled;
  isServiceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!isServiceEnabled) {
    return "Location services are disabled";
  }
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return "Permission denied";
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return "Permission denied forever";
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
    saveLocation(placemark.locality ?? "No location");
    saveLocationPlusCode(placemark.name ?? "00000");
    return address;
  } catch (e) {
    debugPrint(
      "<-----------------------------------------${e.toString()}---------------------------------------------->",
    );
    return e.toString();
  }
}
