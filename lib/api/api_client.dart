import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiClient {
  // ignore: prefer_typing_uninitialized_variables
  final client = http.Client();
  // ignore: constant_identifier_names
  static const String API_URL_PROD = "grassportback.onrender.com";
  // ignore: constant_identifier_names
  static const String API_URL_DEV = "http://192.168.56.1:3000";

  //HERE WE DEFINE THE ENV WE ARE NOW
  // ignore: constant_identifier_names
  static const String API_URL = API_URL_PROD;

  //ENPOINTS
  static const String locationPath = "/ubicacion/geocoding";
  //https://$API_URL_PROD/ubicacion/geocoding?latLng=$lat,$lon

  reverseCode({lat, lon}) async {
    try {
      final uri = Uri.https(API_URL, locationPath, {'latLng': "$lat,$lon"});

      final response = await client.get(uri);

      print(jsonDecode(response.body));

      return jsonDecode(response.body);
    } catch (e) {
      throw Exception(e);
    }
  }
}
