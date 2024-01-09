import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grassport_app/api/api_client.dart';
import 'package:grassport_app/models/cancha_info.dart';
import 'package:grassport_app/models/notification_model.dart';

ApiClient myClient = ApiClient();

class Notifications extends Cubit<NotificationsScaffold?> {
  Notifications() : super(null);

  setNotifications() async {
    NotificationsScaffold data = await myClient.getUserNotifications();
    print('***************************NOTIFICATIONS');
    print(data);
    emit(data);
  }
}
