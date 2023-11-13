import 'package:flutter/material.dart';
import 'package:grassport_app/presentation/styles/colors.dart';
//import 'package:grassport_app/services/systems_settings.dart';

class AlertGPS extends StatefulWidget {
  const AlertGPS({super.key});

  @override
  State<AlertGPS> createState() => _AlertGPSState();
}

class _AlertGPSState extends State<AlertGPS> {
  @override
  void initState() {
    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   Timer(const Duration(seconds: 2), () {
    //     Navigator.pop(context);
    //     Navigator.pop(context);
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: c4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: SizedBox(
        height: 220.0,
        width: 340.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.warning_amber_rounded,
              color: c1,
              size: 90.0,
            ),
            Text(
              "Activa la ubicacion para usar este servicio!",
              style: TextStyle(color: c1, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class LocationTrack extends StatefulWidget {
  const LocationTrack({
    super.key,
  });

  @override
  State<LocationTrack> createState() => _LocationTrackState();
}

class _LocationTrackState extends State<LocationTrack> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: c4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: SizedBox(
        height: 220.0,
        width: 340.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Debe activar el GPS para seguir",
              style: TextStyle(color: c1, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
