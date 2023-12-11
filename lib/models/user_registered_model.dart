class UsersInApp {
  final String nombre;
  final String email;
  final String numero;
  final String fecha_ultimo_ingreso;
  final String fecha_creacion;
  final int conteo_ingresos;
  final String photoURL;

  UsersInApp({
    required this.nombre,
    required this.email,
    required this.numero,
    required this.fecha_ultimo_ingreso,
    required this.fecha_creacion,
    required this.conteo_ingresos,
    this.photoURL =
        'https://firebasestorage.googleapis.com/v0/b/grassportapp-7ccb1.appspot.com/o/profile-ddefault.png?alt=media&token=36401350-8ef2-4483-b277-c3a17461e780',
  });

  static transformBodyArray(body) {
    List<UsersInApp> reportes = [];
    for (Map reporte in body) {
      UsersInApp reportInfo = UsersInApp(
        nombre: reporte['nombre'],
        email: reporte['email'],
        photoURL: reporte['imageURL'],
        numero: reporte['numero'],
        fecha_ultimo_ingreso: reporte['fecha_ultimo_ingreso'],
        fecha_creacion: reporte['fecha_creacion'],
        conteo_ingresos: reporte['conteo_ingresos'],
      );
      reportes.add(reportInfo);
    }

    return reportes;
  }
}
