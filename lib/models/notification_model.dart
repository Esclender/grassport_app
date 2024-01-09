import 'package:flutter/material.dart';
import 'package:grassport_app/api/api_client.dart';
import 'package:grassport_app/models/cancha_info.dart';
import 'package:grassport_app/models/report_model.dart';
import 'package:grassport_app/presentation/router/starting_app_routes.dart';

/**
 * 0 = REPORTS
 * 1 = MIS CANCHAS
 */

ApiClient myClient = ApiClient();

class NotificationsScaffold {
  List<Notificacion> allNotifications;
  List<Notificacion> newNotifications;
  int newNotificationsCount;

  NotificationsScaffold({
    required this.allNotifications,
    required this.newNotifications,
    required this.newNotificationsCount,
  });
}

class Notificacion {
  late String reason;
  late String author;
  late String time;
  late String section;
  late String? idCancha;
  late String? idReporte;
  late bool isNew;
  late int route;

  Notificacion({
    required this.reason,
    required this.author,
    required this.section,
    required this.time,
    required this.isNew,
    required this.route,
    this.idCancha,
    this.idReporte,
  });

  void goToRoute(context) async {
    switch (route) {
      case 0:
        ReportInfo data = await myClient.getReportDetails(idReporte);

        Navigator.pushNamed(context, routeReportDetailed, arguments: data);
        break;
      case 1:
        print(idCancha);
        CanchaInfo canchaDetails =
            await myClient.getNearLocationsDetails(idCancha);

        Navigator.pushNamed(
          context,
          routeCanchaDetails,
          arguments: canchaDetails,
        );
        break;
      default:
    }
  }

  static NotificationsScaffold transformBodyList(body) {
    List<Notificacion> allNotifications = [];
    List<Notificacion> newNotifications = [];
    int newNotificationsCount = body['nuevasNotificacionesCount'];

    for (Map notification in body['allNotificaciones']) {
      Notificacion notificacionToSave = Notificacion(
        reason: notification['razon'],
        author: notification['author'],
        section: notification['seccion'],
        time: notification['tiempo_publicado'],
        isNew: notification['isNuevo'],
        route: notification['route'],
        idCancha: notification['id_cancha'],
        idReporte: notification['id_reporte'],
      );

      allNotifications.add(notificacionToSave);
    }

    for (Map notification in body['nuevasNotificaciones']) {
      Notificacion notificacionToSave = Notificacion(
        reason: notification['razon'],
        author: notification['author'],
        section: notification['seccion'],
        time: notification['tiempo_publicado'],
        isNew: notification['isNuevo'],
        route: notification['route'],
        idCancha: notification['id_cancha'],
        idReporte: notification['id_reporte'],
      );

      newNotifications.add(notificacionToSave);
    }

    return NotificationsScaffold(
      allNotifications: allNotifications,
      newNotifications: newNotifications,
      newNotificationsCount: newNotificationsCount,
    );
  }
}
