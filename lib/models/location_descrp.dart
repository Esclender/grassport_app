import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationDesc {
  late String leading;
  late String street;
  late String locality;
  late Map location;

  LocationDesc({
    required this.leading,
    required this.locality,
    required this.location,
    required this.street,
  });

  LatLng getLocation() {
    return LatLng(location['latitude'], location['longitude']);
  }
}
