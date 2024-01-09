class ReportInfo {
  final String userName;
  final String description;
  final String imageUrl;
  final String email;
  String number;
  String fechaCreacion;
  String comment;

  ReportInfo({
    this.userName = '',
    this.description = '',
    this.imageUrl = '',
    this.email = '',
    this.number = '',
    this.fechaCreacion = '',
    this.comment = '',
  });

  static transformBodyArray(body) {
    List<ReportInfo> reportes = [];

    for (Map reporte in body['response']) {
      ReportInfo reportInfo = ReportInfo(
        userName: reporte['nombre'] ?? 'Usuario Google',
        description: reporte['descripcion'],
        comment: reporte['comentario'],
        imageUrl: reporte['imageURL'],
        email: reporte['email'],
        number: reporte['numero'] ?? '',
        fechaCreacion: reporte['fecha_creacion'] ?? '',
      );
      reportes.add(reportInfo);
    }

    return reportes;
  }

  static transformDetails(body) {
    Map reporte = body['response'];

    return ReportInfo(
      userName: reporte['nombre'] ?? 'Usuario Google',
      description: reporte['descripcion'] ?? '',
      imageUrl: reporte['imageURL'] ?? '',
      email: reporte['email'] ?? '',
      number: reporte['numero'] ?? '',
      fechaCreacion: reporte['fecha_creacion'] ?? '',
      comment: reporte['comentario'],
    );
  }
}
