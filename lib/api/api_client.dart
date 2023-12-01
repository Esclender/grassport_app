import 'dart:convert';

import 'package:grassport_app/models/cancha_info.dart';
import 'package:grassport_app/models/location_descrp.dart';
import 'package:grassport_app/services/save_preferens.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  // ignore: prefer_typing_uninitialized_variables
  final client = http.Client();
  // ignore: constant_identifier_names
  static const String API_URL_PROD = "15.228.163.12:3000";

  //HERE WE DEFINE THE ENV WE ARE NOW
  // ignore: constant_identifier_names
  static const String API_URL = API_URL_PROD;

  //ENPOINTS
  static const String getTokenPath = "/usuarios";
  static const String getMyHistoryPath = "/usuarios/mis-datos/historial";

  static const String locationPath = "/ubicacion/geocoding";
  static const String nearLocationsPath =
      "/ubicacion/geocoding/nearbyLocations";
  static const String addressSearchPath = "/ubicacion/geocoding/address";
  static const String userHistoryLocation = "/ubicacion/user-history";

  reverseCode({lat, lon}) async {
    try {
      final uri = Uri.http(API_URL, locationPath, {'latLng': "$lat,$lon"});
      final response = await client.get(uri);

      return jsonDecode(response.body);
    } catch (e) {
      throw Exception(e);
    }
  }

  getNearLocations({lat, lon}) async {
    try {
      final uri = Uri.http(API_URL, nearLocationsPath, {'latLng': "$lat,$lon"});
      final response = await client.get(uri);
      final dataNoMapped = jsonDecode(response.body);
      List<CanchaInfo> canchas = CanchaInfo.transformResponse(dataNoMapped);

      return canchas;
    } catch (e) {
      throw Exception(e);
    }
  }

  searchByAddress({search}) async {
    try {
      final uri = Uri.http(API_URL, addressSearchPath, {'street': search});
      final response = await client.get(
        uri,
      );

      return jsonDecode(response.body);
    } catch (e) {
      throw Exception(e);
    }
  }

  getToken({email}) async {
    try {
      final uri = Uri.http(API_URL, getTokenPath);
      final response = await client.post(uri, body: {'email': email});

      Map data = jsonDecode(response.body);

      await Cookies().save(key: 'userToken', value: data['token']);
    } catch (e) {
      throw Exception(e);
    }
  }

  saveHistoryLocation({LocationDesc? lugar}) async {
    try {
      String isToken = await Cookies().load(key: 'userToken');
      final uri = Uri.http(API_URL, userHistoryLocation);

      await client.post(
        uri,
        body: json.encode(
          {"data": lugar?.getObject()},
        ),
        headers: {
          (isToken != '' ? 'Authorization' : ''): 'Bearer $isToken',
          'Content-type': 'application/json',
          "Accept": "application/json",
        },
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  //ONLY LOGGED USERS
  getMyHistory() async {
    try {
      String isToken = await Cookies().load(key: 'userToken');
      final uri = Uri.http(API_URL, getMyHistoryPath);

      final userHistory = await client.get(
        uri,
        headers: {
          'Authorization': 'Bearer $isToken',
        },
      );

      return jsonDecode(userHistory.body);
    } catch (e) {
      throw Exception(e);
    }
  }
}
