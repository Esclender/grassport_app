/**
 * 0 = REPORTS
 * 1 = MIS CANCHAS
 */

class Notificacion {
  late String reason;
  late String author;
  late String time;
  late String section;
  late bool isNew;
  late int route;

  Notificacion({
    required this.reason,
    required this.author,
    required this.section,
    required this.time,
    required this.isNew,
    required this.route,
  });
}
