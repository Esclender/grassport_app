import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoggedUser extends Cubit<UserCredential?> {
  LoggedUser() : super(null);

  void setData(UserCredential? data) {
    emit(data);
  }
}
