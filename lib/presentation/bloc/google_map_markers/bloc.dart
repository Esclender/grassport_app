import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grassport_app/api/api_client.dart';
import 'package:grassport_app/models/cancha_info.dart';

class GoogleMapMarkers extends Cubit<Set<Marker>> {
  GoogleMapMarkers() : super({}); //CONSUME ALL MARKERS OF GOOGLE MAPS HERE

  setMarkers(context, currentLocation) async {
    List<CanchaInfo> dataCanchas = await ApiClient().getNearLocations(
        lat: currentLocation?.latitude, lon: currentLocation?.longitude);

    BitmapDescriptor markerCancha = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      "assets/app_icons/cancha_icon_location.png",
    );

    // ignore: use_build_context_synchronously
    for (CanchaInfo cancha in dataCanchas) {
      emit({
        ...state,
        Marker(
          markerId: MarkerId(cancha.address),
          position: LatLng(cancha.location.latitude, cancha.location.longitude),
          icon: markerCancha,
          infoWindow: InfoWindow(
            title: cancha.nombre,
            anchor: const Offset(0.5, 0.1),
          ),
        )
      });
    }
  }

  //TODO: CANCHA CAN'T BE NULL
  setSingleMarker(CanchaInfo cancha) async {
    BitmapDescriptor markerCancha = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      "assets/app_icons/cancha_icon_location.png",
    );

    emit({
      ...state,
      Marker(
        markerId: MarkerId(cancha.address),
        position: LatLng(cancha.location.latitude, cancha.location.longitude),
        icon: markerCancha,
        infoWindow: InfoWindow(
          title: cancha.nombre,
          anchor: const Offset(0.5, 0.1),
        ),
      )
    });
  }

  setUserMarker(LatLng location) async {
    BitmapDescriptor markerIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      "assets/app_icons/Current_Location_Marker.png",
    );

    state.removeWhere((Marker element) => element.position == location);

    emit({
      ...state,
      Marker(
        markerId: const MarkerId('Posicion'),
        position: location,
        icon: markerIcon,
      )
    });
  }

  clear() {
    state.clear();
  }
}

class CanchasByInout extends Cubit<List> {
  CanchasByInout() : super([]);

  getCanchasByInput({query = ''}) async {
    List locations = await ApiClient().searchCanchas(search: query);

    emit([...locations]);

    //change by the search places
  }

  setCanchasByInput(value) {
    emit(value);
  }
}
