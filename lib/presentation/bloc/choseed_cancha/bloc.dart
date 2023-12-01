import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grassport_app/models/cancha_info.dart';

var nearCanchas = [];

class ChoseedCancha extends Cubit<int> {
  ChoseedCancha() : super(0);

  CanchaInfo getCanchaSpec() {
    return nearCanchas[state];
  }

  void changeInd(ind) {
    emit(ind);
  }
}
