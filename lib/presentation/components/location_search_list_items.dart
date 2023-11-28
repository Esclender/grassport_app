import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grassport_app/api/api_client.dart';
import 'package:grassport_app/models/location_descrp.dart';
import 'package:grassport_app/presentation/bloc/charge/bloc.dart';
import 'package:grassport_app/presentation/bloc/device_current_location/blocs.dart';
import 'package:grassport_app/presentation/router/starting_app_routes.dart';
import 'package:grassport_app/presentation/styles/colors.dart';

class LocationTag extends StatelessWidget {
  final LatLng latLng;
  final Widget leading;
  final String department;
  final String location;
  const LocationTag({
    super.key,
    required this.leading,
    required this.department,
    required this.location,
    required this.latLng,
  });

  @override
  Widget build(BuildContext context) {
    context.read<ChargeRoute>().changeRoute(routeHomeApp);
    return TextButton(
        onPressed: () async {
          LocationDesc savedLocation = LocationDesc(
            leading: 'history',
            locality: department,
            location: {'lat': latLng.latitude, 'lng': latLng.longitude},
            street: location,
          );

          print('*********************************************HISTORY');
          print(latLng);

          await ApiClient().saveHistoryLocation(lugar: savedLocation);

          // ignore: use_build_context_synchronously
          context.read<DeviceGpsLocation>().setGpsLocation(latLng);
          // ignore: use_build_context_synchronously
          Navigator.pushNamed(context, routeCharge);
        },
        style: TextButton.styleFrom(
          foregroundColor: c9,
        ),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: leading,
          title: Text(department),
          subtitle: Text(location),
        ));
  }
}
