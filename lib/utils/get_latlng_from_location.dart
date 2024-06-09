import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:haathbarhao_mobile/gen/colors.gen.dart';

Future<bool> handleLocationPermission() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    Fluttertoast.showToast(
      msg: 'Location services are disabled. Please enable the services.',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.SNACKBAR,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.redAccent,
      textColor: ColorName.white,
      fontSize: 16.0,
    );

    return false;
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      Fluttertoast.showToast(
        msg: 'Location permissions are denied.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.redAccent,
        textColor: ColorName.white,
        fontSize: 16.0,
      );

      return false;
    }
  }
  if (permission == LocationPermission.deniedForever) {
    Fluttertoast.showToast(
      msg:
          'Location permissions are permanently denied, we cannot request permissions.',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.SNACKBAR,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.redAccent,
      textColor: ColorName.white,
      fontSize: 16.0,
    );

    return false;
  }
  return true;
}

Future<String?> getLatLngFromGeolocation() async {
  try {
    final hasPermission = await handleLocationPermission();
    if (!hasPermission) {
      return null;
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    return '${position.latitude}, ${position.longitude}';
  } on Exception catch (e) {
    Fluttertoast.showToast(
      msg: e.toString(),
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.SNACKBAR,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.redAccent,
      textColor: ColorName.white,
      fontSize: 16.0,
    );
  }

  return null;
}
