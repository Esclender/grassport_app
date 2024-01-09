import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grassport_app/models/logged_user.dart';

class LoggedUser extends Cubit<UserDisplayed?> {
  LoggedUser() : super(null);

  void setData(UserDisplayed? data) {
    emit(data);
  }
}
