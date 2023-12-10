import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grassport_app/models/logged_user.dart';
import 'package:grassport_app/presentation/bloc/loged_user_data/bloc.dart';
import 'package:grassport_app/presentation/router/starting_app_routes.dart';
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

  static String extractPhotoURL(String token) {
    try {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

      String url = decodedToken['photoURL'];
      return url;
    } catch (e) {
      // Token decoding or validation failed
      return '';
    }
  }

  static manageViews(BuildContext context) {
    UserDisplayed? user = context.read<LoggedUser>().state;

    switch (user?.account) {
      case 'user':
        Navigator.pushNamed(context, routeAgreementLocation);
        break;
      case 'admin':
        Navigator.pushNamed(context, routeToAdminPanel);
        break;
      default:
    }
  }
}
