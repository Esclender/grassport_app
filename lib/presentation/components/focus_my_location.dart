import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grassport_app/presentation/bloc/device_current_location/blocs.dart';
import 'package:grassport_app/presentation/bloc/google_map_markers/bloc.dart';
import 'package:grassport_app/presentation/styles/colors.dart';

class MyLocationFocusButton extends StatelessWidget {
  const MyLocationFocusButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'Focus Button',
      onPressed: () {
        LatLng? myLocationToFocus = context.read<DeviceGpsLocation>().state;

        context
            .read<GoogleMapMarkers>()
            .setUserMarker(myLocationToFocus as LatLng);
      },
      backgroundColor: c1,
      mini: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
      ),
      child: Icon(
        Icons.gps_fixed_sharp,
        color: c9,
      ),
    );
  }
}
