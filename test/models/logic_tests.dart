import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grassport_app/api/api_client.dart';

ApiClient myClient = ApiClient();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  group('Pruebas Logicas GRASSPORT', () {
    test('Ingreso devuelve Token', () async {
      Map credentials = {
        "email": "elesclenderlugo@gmail.com",
        "clave": "1234",
      };

      var response = await myClient.login(
        email: credentials['email'],
        clave: credentials['clave'],
      );

      // ignore: avoid_print
      print({"token": response});

      expect(response, isA<String>());
    });

    test('Obtencion de historial de usuario', () async {
      Map credentials = {
        "email": "gilmer48.mm@gmail.com",
        "clave": "1234",
      };

      var token = await myClient.login(
        email: credentials['email'],
        clave: credentials['clave'],
      );

      Map<String, dynamic> response =
          await myClient.getMyHistory(isToken: token);

      List historial = response["historial"];

      // ignore: avoid_print
      print({
        "historial": historial,
      });

      expect(historial.isNotEmpty, true);
    });
  });
}
