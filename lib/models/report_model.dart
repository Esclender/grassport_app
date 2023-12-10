class ReportInfo {
  final String userName;
  final String description;
  final String imageUrl;
  final String email;
  String number;

  ReportInfo({
    this.userName = '',
    this.description = '',
    this.imageUrl = '',
    this.email = '',
    this.number = '',
  });

  static transformBodyArray(body) {
    List<ReportInfo> reportes = [];

    for (Map reporte in body['response']) {
      ReportInfo reportInfo = ReportInfo(
        userName: reporte['nombre'] ?? 'Usuario Google',
        description: reporte['descripcion'],
        imageUrl: reporte['imageURL'],
        email: reporte['email'],
        number: reporte['numero'] ?? '',
      );
      reportes.add(reportInfo);
    }

    return reportes;
  }
}
