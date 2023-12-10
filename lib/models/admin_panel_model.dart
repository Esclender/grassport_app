import 'package:grassport_app/models/bar_graphic_model.dart';

class AdminPanel {
  final String adminName;
  final String adminEmail;
  final String photoURL;
  final int totalUsers;
  final int totalReports;
  final int totalReportsOfWeek;
  final List<BarData> topUsers;
  final double maxPlusTen;

  AdminPanel({
    required this.adminName,
    required this.adminEmail,
    required this.photoURL,
    required this.totalUsers,
    required this.totalReports,
    required this.totalReportsOfWeek,
    required this.topUsers,
    required this.maxPlusTen,
  });

  static transformBody(body) {
    Map data = body['response'];

    List<BarData> bars =
        BarData.transformBodyArray(data['topUsersWithImageURLs']);

    BarData maxBar =
        bars[0]; // Assume the first bar has the max value initially

    for (BarData bar in bars) {
      if (bar.value > maxBar.value) {
        maxBar = bar;
      }
    }

    AdminPanel adminPanel = AdminPanel(
      adminName: data['admin_info']['nombre'],
      adminEmail: data['admin_info']['email'],
      photoURL: data['admin_info']['imageURL'],
      totalUsers: data['usuariosCount'],
      totalReports: data['reportesCount'],
      totalReportsOfWeek: data['reports_week'],
      topUsers: bars,
      maxPlusTen: maxBar.value + 10,
    );

    return adminPanel;
  }
}
