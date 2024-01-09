import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grassport_app/api/api_client.dart';
import 'package:grassport_app/models/cancha_info.dart';
import 'package:grassport_app/models/lis_item_model.dart';

ApiClient myClient = ApiClient();

class GoogleMapMarkers extends Cubit<Set<Marker>> {
  GoogleMapMarkers() : super({}); //CONSUME ALL MARKERS OF GOOGLE MAPS HERE

  setMarkers(context, currentLocation) async {
    Set<Marker> newSet = {};

    List<CanchaMarker> dataCanchas = await myClient.getNearLocations(
        lat: currentLocation?.latitude, lon: currentLocation?.longitude);

    BitmapDescriptor markerCancha = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      "assets/app_icons/cancha_icon_location.png",
    );

    // ignore: use_build_context_synchronously
    for (CanchaMarker cancha in dataCanchas) {
      newSet.add(
        Marker(
          markerId: MarkerId(cancha.placeId),
          position: cancha.location,
          icon: markerCancha,
          infoWindow: InfoWindow(
            title: cancha.nombre,
            anchor: const Offset(0.5, 0.1),
          ),
        ),
      );
    }

    emit(newSet);
  }

  setSingleMarker(CanchaMarker cancha) async {
    BitmapDescriptor markerCancha = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      "assets/app_icons/cancha_icon_location.png",
    );

    emit({
      ...state,
      Marker(
        markerId: MarkerId(cancha.placeId),
        position: cancha.location,
        icon: markerCancha,
        infoWindow: InfoWindow(
          title: cancha.nombre,
          anchor: const Offset(0.5, 0.1),
        ),
      )
    });
  }

  setUserMarker(LatLng newLocation) async {
    BitmapDescriptor markerIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      "assets/app_icons/Current_Location_Marker.png",
    );

    state.removeWhere(
      (Marker element) => element.markerId == MarkerId('Posicion'),
    );

    emit({
      ...state,
      Marker(
        markerId: const MarkerId('Posicion'),
        position: newLocation,
        icon: markerIcon,
      )
    });
  }

  clear() {
    state.clear();
  }
}

class CanchasByInput extends Cubit<List<LocationTagModel>> {
  CanchasByInput() : super([]);

  getCanchasByInput({query = ''}) async {
    List<LocationTagModel> locations =
        await myClient.searchCanchas(search: query);

    emit([...locations]);

    //change by the search places
  }

  setCanchasByInput(value) {
    emit(value);
  }
}
