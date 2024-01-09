import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grassport_app/api/api_client.dart';
import 'package:grassport_app/models/cancha_info.dart';

List nearCanchas = [];
ApiClient myClient = ApiClient();

class NearCanchas extends Cubit<List<CanchaMarker>> {
  NearCanchas() : super([]);

  setNearCanchas(List<CanchaMarker> data) {
    emit([...data]);
  }

  setDefintive(data) {
    emit(data);
  }

  Future<void> getNearCanchas({LatLng? currentLocation}) async {
    List<CanchaMarker> dataCanchas = await myClient.getNearLocations(
      lat: currentLocation?.latitude,
      lon: currentLocation?.longitude,
    );

    //emit([...dataCanchas]);
    emit(dataCanchas);
  }
}
