import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoggedUser extends Cubit<User?> {
  LoggedUser() : super(null);

  void setData(User? data) {
    emit(data);
  }
}
