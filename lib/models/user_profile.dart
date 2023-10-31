class UserProfile {
  String nombre;
  String apellido;
  String numero;

  UserProfile({
    required this.nombre,
    required this.apellido,
    this.numero = "",
  });
}
