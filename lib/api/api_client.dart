import 'dart:convert';
import 'dart:io';
import 'package:grassport_app/models/admin_panel_model.dart';
import 'package:grassport_app/models/report_model.dart';
import 'package:grassport_app/models/user_registered_model.dart';
import 'package:http_parser/http_parser.dart';
import 'package:grassport_app/models/cancha_info.dart';
import 'package:grassport_app/models/location_descrp.dart';
import 'package:grassport_app/models/user_profile.dart';
import 'package:grassport_app/services/save_preferens.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class ApiClient {
  // ignore: prefer_typing_uninitialized_variables
  final client = http.Client();
  // ignore: constant_identifier_names
  static const String API_URL_PROD = "54.207.102.152:3000"; //""

  //HERE WE DEFINE THE ENV WE ARE NOW
  // ignore: constant_identifier_names
  static const String API_URL = API_URL_PROD;

  //ENPOINTS
  static const String getTokenPath = "/usuarios";
  static const String registerPath = "/usuarios/registro";
  static const String loginPath = "/usuarios/login";
  static const String getMyHistoryPath = "/usuarios/mis-datos/historial";
  static const String saveFavoritesPath = "/usuarios/favoritos";
  static const String getFavoritesPath = "/usuarios/mis-datos/favoritos";
  static const String userDataPath = "/usuarios/mis-datos";
  static const String reportProblemPath = "/usuarios/report";

  static const String locationPath = "/ubicacion/geocoding";
  static const String nearLocationsPath =
      "/ubicacion/geocoding/nearbyLocations";
  static const String searchCanchasPath = "/ubicacion/geocoding/canchas";
  static const String addressSearchPath = "/ubicacion/geocoding/address";
  static const String userHistoryLocation = "/ubicacion/user-history";

  //ADMINS
  static const String getAllReportsPath = "/admins/report";
  static const String getUsersListPath = "/admins/usuarios";
  static const String adminPanelPath = "/admins/panel";

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

  searchCanchas({search}) async {
    try {
      final uri = Uri.http(API_URL, searchCanchasPath, {'nombre': search});
      final response = await client.get(
        uri,
      );
      final dataJson = jsonDecode(response.body);

      return dataJson['response'];
    } catch (e) {
      throw Exception(e);
    }
  }

  getToken({email, nombre, photoURL}) async {
    try {
      final uri = Uri.http(API_URL, getTokenPath);
      final response = await client.post(uri, body: {
        'email': email,
        'nombre': nombre,
        'photoURL': photoURL,
      });

      Map data = jsonDecode(response.body);
      await Cookies().save(key: 'userToken', value: data['token']);

      return data['token'];
    } catch (e) {
      throw Exception(e);
    }
  }

  login({email, clave}) async {
    try {
      final uri = Uri.http(API_URL, loginPath);
      final response = await client.post(uri, body: {
        'email': email,
        'clave': clave,
      });

      Map data = jsonDecode(response.body);
      await Cookies().save(key: 'userToken', value: data['token']);

      return data['token'];
    } catch (e) {
      throw Exception(e);
    }
  }

  registerUser({
    required File image,
    required String email,
    required String nombre,
    required String apellido,
    required String numero,
    required String clave,
  }) async {
    try {
      final uri = Uri.http(API_URL, registerPath);

      http.MultipartRequest request = http.MultipartRequest('POST', uri);

      request.fields['email'] = email;
      request.fields['nombre'] = nombre;
      request.fields['apellido'] = apellido;
      request.fields['numero'] = numero;
      request.fields['clave'] = clave;

      request.files.add(
        http.MultipartFile(
          'image',
          http.ByteStream(image.openRead().cast()),
          await image.length(),
          filename: basename(image.path),
          contentType: MediaType('image', 'jpeg'),
        ),
      );

      http.StreamedResponse streamedResponse = await request.send();
      http.Response response = await http.Response.fromStream(streamedResponse);
      Map responseJSON = jsonDecode(response.body);

      return responseJSON['response'];
    } catch (e) {
      throw Exception(e);
    }
  }

  //ONLY LOGGED USERS
  getUserData({email}) async {
    try {
      String isToken = await Cookies().load(key: 'userToken');
      final uri = Uri.http(API_URL, userDataPath);

      final userData = await client.get(
        uri,
        headers: {
          'Authorization': 'Bearer $isToken',
        },
      );

      final docJson = jsonDecode(userData.body);
      final doc = docJson['response'];

      UserProfile user = UserProfile(
        nombre: doc['nombre'] ?? '',
        apellido: doc['apellido'] ?? '',
        numero: doc['numero'] ?? '',
      );

      return user;
    } catch (e) {
      throw Exception(e);
    }
  }

  saveUserData({UserProfile? user}) async {
    try {
      String token = await Cookies().load(key: 'userToken');
      final uri = Uri.http(API_URL, userDataPath);

      await client.post(
        uri,
        body: json.encode(
          user?.getObject(),
        ),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-type': 'application/json',
          "Accept": "application/json",
        },
      );
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

  saveFavorite({CanchaInfo? lugar}) async {
    try {
      String token = await Cookies().load(key: 'userToken');
      final uri = Uri.http(API_URL, saveFavoritesPath);

      await client.post(
        uri,
        body: json.encode(
          {"data": lugar?.getObjectForFavorites()},
        ),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-type': 'application/json',
          "Accept": "application/json",
        },
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  getMyFavorites() async {
    try {
      String token = await Cookies().load(key: 'userToken');
      final uri = Uri.http(API_URL, getFavoritesPath);

      final userFavorites = await client.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      final dataNoMapped = jsonDecode(userFavorites.body);

      List<CanchaInfo> favoritos =
          CanchaInfo.transformResponseInCanchas(dataNoMapped);

      return favoritos;
    } catch (e) {
      throw Exception(e);
    }
  }

  reportProblem(File image, String description) async {
    try {
      String token = await Cookies().load(key: 'userToken');
      final uri = Uri.http(API_URL, reportProblemPath);

      http.MultipartRequest request = http.MultipartRequest('POST', uri);

      request.headers['Authorization'] = 'Bearer $token';

      request.files.add(
        http.MultipartFile(
          'image',
          http.ByteStream(image.openRead().cast()),
          await image.length(),
          filename: basename(image.path),
          contentType: MediaType('image', 'jpeg'),
        ),
      );

      request.fields['descripcion'] = description;

      await request.send();
    } catch (e) {
      throw Exception(e);
    }
  }
  //ADMIN ENPOINTS

  getAdminPanel() async {
    try {
      String token = await Cookies().load(key: 'userToken');
      final uri = Uri.http(API_URL, adminPanelPath);

      final panelData = await client.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      final docJson = jsonDecode(panelData.body);

      AdminPanel panel = AdminPanel.transformBody(docJson);

      return panel;
    } catch (e) {
      throw Exception(e);
    }
  }

  getAllReports() async {
    try {
      String token = await Cookies().load(key: 'userToken');
      final uri = Uri.http(API_URL, getAllReportsPath);

      final listOfReports = await client.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      final docJson = jsonDecode(listOfReports.body);

      List<ReportInfo> reports = ReportInfo.transformBodyArray(docJson);

      return reports;
    } catch (e) {
      throw Exception(e);
    }
  }

  getUsersRegisteredList({
    filtroName = '',
    orderBy = 'fecha_creacion',
    orden = 'asc',
  }) async {
    try {
      String token = await Cookies().load(key: 'userToken');
      final uri = Uri.http(API_URL, getUsersListPath, {
        'nombre': filtroName,
        'orden': "$orderBy,$orden",
      });

      final listOfUsers = await client.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      final docJson = jsonDecode(listOfUsers.body);

      List<UsersInApp> listUsers =
          UsersInApp.transformBodyArray(docJson['response']['lista_usuarios']);

      return listUsers;
    } catch (e) {
      throw Exception(e);
    }
  }

  getTopUsersRegistered() async {
    try {
      String token = await Cookies().load(key: 'userToken');
      final uri = Uri.http(API_URL, getUsersListPath);

      final listOfUsers = await client.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      final docJson = jsonDecode(listOfUsers.body);

      List<UsersInApp> listUsers =
          UsersInApp.transformBodyArray(docJson['response']['topIngresos']);

      return listUsers;
    } catch (e) {
      throw Exception(e);
    }
  }
}
