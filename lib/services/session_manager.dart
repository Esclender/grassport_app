import 'package:jwt_decoder/jwt_decoder.dart';

class SessionManager {
  static bool isTokenExpired(String? token) {
    if (token == null) {
      return true;
    }

    try {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      if (decodedToken['exp'] * 1000 < DateTime.now().millisecondsSinceEpoch) {
        return true;
      }

      return false;
    } catch (e) {
      // Token decoding or validation failed
      return true;
    }
  }

  static bool extractIsAdmin(String token) {
    try {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

      bool isAdmin = decodedToken['isAdmin'];
      return isAdmin;
    } catch (e) {
      // Token decoding or validation failed
      return false;
    }
  }

  static String extractNombre(String token) {
    try {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

      String nombre = decodedToken['nombre'];
      return nombre;
    } catch (e) {
      // Token decoding or validation failed
      return '';
    }
  }
}
