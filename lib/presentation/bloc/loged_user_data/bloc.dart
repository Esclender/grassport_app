import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grassport_app/models/user_profile.dart';

UserProfile userLogged =
    UserProfile(nombre: "Esclender", apellido: "Lugo", numero: "928590695");

class LoggedUser extends Cubit<UserProfile> {
  LoggedUser() : super(userLogged);
}
