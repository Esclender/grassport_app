import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DeviceGpsLocation extends Cubit<LatLng?> {
  DeviceGpsLocation()
      : super(null); //0 is equal to history and 1 equal to serch places

  void setGpsLocation(LatLng event) {
    print(
        '***********************************************************SETTING THE GPS');
    print(event);
    emit(event);
  }
}
