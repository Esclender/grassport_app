import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiClient {
  // ignore: prefer_typing_uninitialized_variables
  final client = http.Client();
  // ignore: constant_identifier_names
  static const String API_URL_PROD = "grassportback.onrender.com";

  //HERE WE DEFINE THE ENV WE ARE NOW
  // ignore: constant_identifier_names
  static const String API_URL = API_URL_PROD;

  //ENPOINTS
  static const String locationPath = "/ubicacion/geocoding";
  static const String addressSearchPath = "/ubicacion/geocoding/address";

  reverseCode({lat, lon}) async {
    try {
      final uri = Uri.https(API_URL, locationPath, {'latLng': "$lat,$lon"});

      final response = await client.get(uri);

      return jsonDecode(response.body);
    } catch (e) {
      throw Exception(e);
    }
  }

  searchByAddress({search}) async {
    try {
      final uri = Uri.https(API_URL, addressSearchPath, {'street': search});
      final response = await client.get(uri);
      //final data = ;

      // List<LocationDesc> results = data['response'].map((item) {
      //   LocationDesc mapped = LocationDesc(
      //       leading: item['leading'],
      //       locality: item['locality'],
      //       location: item["location"],
      //       street: item["street"]);

      //   return mapped;
      // });

      // print(results);

      return jsonDecode(response.body);
    } catch (e) {
      throw Exception(e);
    }
  }
}
