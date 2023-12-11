import 'package:google_maps_flutter/google_maps_flutter.dart';

class CanchaInfo {
  LatLng location;
  String nombre;
  int rating;
  String address;
  bool isOpen;
  String photoURL;

  CanchaInfo({
    required this.nombre,
    required this.address,
    this.rating = 0,
    required this.isOpen,
    required this.location,
    this.photoURL = '',
  });

  Map getObjectForFavorites() {
    return {
      "location": {"lat": location.latitude, "lng": location.longitude},
      "locality": nombre,
      "street": address,
    };
  }

  static List<CanchaInfo> transformResponse(body) {
    List<CanchaInfo> canchas = [];

    for (Map cancha in body['response']) {
      CanchaInfo canchaInfo = CanchaInfo(
        nombre: cancha['name'],
        photoURL: cancha['photoURL'],
        address: cancha['address'],
        rating: cancha['rating'],
        isOpen: cancha['isOpen'] ?? false,
        location: LatLng(
            cancha['location']['latitude'], cancha['location']['longitude']),
      );
      canchas.add(canchaInfo);
    }

    return canchas;
  }

  static List<CanchaInfo> transformResponseInCanchas(body) {
    List<CanchaInfo> canchas = [];

    for (Map cancha in body['response']) {
      CanchaInfo canchaInfo = CanchaInfo(
        nombre: cancha['locality'],
        address: cancha['street'],
        isOpen: true,
        location: LatLng(cancha['location']['lat'], cancha['location']['lng']),
      );
      canchas.add(canchaInfo);
    }

    return canchas;
  }
}
