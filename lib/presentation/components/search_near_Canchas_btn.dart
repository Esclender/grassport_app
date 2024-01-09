import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grassport_app/presentation/bloc/google_map_markers/bloc.dart';
import 'package:grassport_app/presentation/components/alerts.dart';
import 'package:grassport_app/presentation/styles/colors.dart';

class MySearchCanchasButton extends StatelessWidget {
  const MySearchCanchasButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'Location Tag',
      onPressed: () async {
        CustomDialogs.showSearchingDialog(
          context,
          'Buscando Canchas...',
        ); //'Buscando Canchas...'

        try {
          Position? currentPosition = await Geolocator.getCurrentPosition();

          LatLng myLocation = LatLng(
            currentPosition.latitude,
            currentPosition.longitude,
          );

          try {
            // ignore: use_build_context_synchronously
            await context
                .read<GoogleMapMarkers>()
                .setMarkers(context, myLocation);
          } finally {
            // ignore: use_build_context_synchronously
            context.read<GoogleMapMarkers>().setUserMarker(
                  myLocation,
                );
          }
        } finally {
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
        }
      },
      backgroundColor: c1,
      mini: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
      ),
      child: Icon(
        Icons.search,
        color: c9,
      ),
    );
  }
}
