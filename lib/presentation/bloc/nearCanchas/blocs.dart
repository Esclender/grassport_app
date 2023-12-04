import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grassport_app/api/api_client.dart';
import 'package:grassport_app/models/cancha_info.dart';

var nearCanchas = [];

class NearCanchas extends Cubit<List<CanchaInfo>> {
  NearCanchas() : super([]);

  setNearCanchas(List<CanchaInfo> data) {
    emit([...data]);
  }

  Future<Set<Marker>> getNearCanchas({LatLng? currentLocation}) async {
    List<CanchaInfo> dataCanchas = await ApiClient().getNearLocations(
        lat: currentLocation?.latitude, lon: currentLocation?.longitude);

    emit([...dataCanchas]);

    Set<Marker> markers = {};

    BitmapDescriptor markerCancha = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      "assets/app_icons/cancha_icon_location.png",
    );

    // ignore: use_build_context_synchronously
    for (CanchaInfo cancha in dataCanchas) {
      markers.add(Marker(
        markerId: MarkerId(cancha.address),
        position: LatLng(cancha.location.latitude, cancha.location.longitude),
        icon: markerCancha,
        infoWindow: InfoWindow(
          title: cancha.nombre,
          anchor: const Offset(0.5, 0.1),
        ),
      ));
    }

    return markers;
  }
}
