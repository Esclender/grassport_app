import 'package:flutter_bloc/flutter_bloc.dart';

class IsAdmin extends Cubit<bool> {
  IsAdmin() : super(false);

  void setIsAdmin(bool isAdmin) {
    emit(isAdmin);
  }
}
