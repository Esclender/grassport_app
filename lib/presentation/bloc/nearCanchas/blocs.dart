import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grassport_app/models/cancha_info.dart';

var nearCanchas = [];

class NearCanchas extends Cubit<List> {
  NearCanchas() : super(nearCanchas);

  getNearCanchas(List<CanchaInfo> data) {
    emit(state);
  }
}
