import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationTagModel {
  LatLng location;
  String leading;
  String department;
  String street;
  String placeId;

  LocationTagModel({
    required this.leading,
    required this.location,
    required this.department,
    required this.street,
    required this.placeId,
  });

  static List<LocationTagModel> transformResponse(body) {
    List<LocationTagModel> canchas = [];

    for (Map cancha in body['response']) {
      LocationTagModel canchaInfo = LocationTagModel(
        leading: cancha['leading'],
        street: cancha['street'],
        department: cancha['locality'],
        placeId: cancha['place_id'] ?? '',
        location: LatLng(
            cancha['location']['latitude'], cancha['location']['longitude']),
      );
      canchas.add(canchaInfo);
    }

    return canchas;
  }
}
