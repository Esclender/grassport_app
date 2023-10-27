import 'package:flutter_bloc/flutter_bloc.dart';

class IsProfile extends Cubit<bool> {
  IsProfile() : super(false);

  void toogleProfile(bol) {
    emit(bol);
  }
}
