import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grassport_app/models/cancha_info.dart';
import 'package:grassport_app/presentation/bloc/home_view_selected/bloc.dart';
import 'package:grassport_app/presentation/bloc/notifications/bloc.dart';
import 'package:grassport_app/presentation/components/fav_notif_list.dart';
import 'package:grassport_app/presentation/components/home_badget.dart';
import 'package:grassport_app/presentation/components/notifacion_list.dart';

class NotifView extends StatefulWidget {
  const NotifView({super.key});

  @override
  State<NotifView> createState() => _NotifViewState();
}

class _NotifViewState extends State<NotifView> {
  @override
  Widget build(BuildContext context) {
    HomeView selectedIcon = context.watch<HomeView>();

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            selectedIcon.changeView(0);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text("Notificaciones"),
        centerTitle: true,
      ),
      body: Stack(
        children: [NotificationList()],
      ),
    );
  }
}
