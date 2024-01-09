import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:grassport_app/presentation/bloc/locations/blocs.dart';
import 'package:grassport_app/presentation/components/popus/activate_gps.dart';

Future<Position> checkIsGpsEnabled({required BuildContext context}) async {
  LocationPermission permission;

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) => const AlertGPS(),
      );
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }
  }

  // ignore: use_build_context_synchronously
  context.read<IsGpsEnabled>().setGpsPermissions(true);
  // ignore: use_build_context_synchronously
  return await Geolocator.getCurrentPosition();
}
