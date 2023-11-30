import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grassport_app/models/cancha_info.dart';

List<CanchaInfo> notifications = [];

class Notifications extends Cubit<List<CanchaInfo>> {
  Notifications() : super(notifications);
}
