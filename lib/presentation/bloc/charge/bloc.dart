import 'package:flutter_bloc/flutter_bloc.dart';

class ChargeRoute extends Cubit<String> {
  ChargeRoute()
      : super('/'); //0 is equal to history and 1 equal to serch places

  void changeRoute(String route) {
    emit(route);
  }
}
