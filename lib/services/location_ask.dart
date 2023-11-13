import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grassport_app/presentation/components/popus/activate_gps.dart';

Future<Position> checkIsGpsEnabled({context}) async {
  LocationPermission permission;

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      showDialog(
        context: context,
        builder: (context) => const AlertGPS(),
      );
      Navigator.pop(context);
    }
  }

  // ignore: use_build_context_synchronously
  return await Geolocator.getCurrentPosition();
}
