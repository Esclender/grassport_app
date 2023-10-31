import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends Cubit<int> {
  HomeView() : super(0);

  void changeView(ind) {
    emit(ind);
  }
}
