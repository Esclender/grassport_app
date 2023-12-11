class UserProfile {
  String nombre;
  String apellido;
  String numero;

  UserProfile({
    this.nombre = '',
    this.apellido = '',
    this.numero = '',
  });

  getObject() {
    return {
      "nombre": nombre,
      "apellido": apellido,
      "numero": numero,
    };
  }
}
