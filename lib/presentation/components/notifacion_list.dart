import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:grassport_app/models/notification_model.dart';
import 'package:grassport_app/presentation/components/shapes.dart';
import 'package:grassport_app/presentation/router/starting_app_routes.dart';
import 'package:grassport_app/presentation/styles/colors.dart';

// ignore: must_be_immutable
class NotificationList extends StatefulWidget {
  NotificationList({super.key});

  @override
  State<NotificationList> createState() => _SavedListState();
}

class _SavedListState extends State<NotificationList> {
  List<Notificacion> data = [];

  @override
  void initState() {
    setNotifications();
    super.initState();
  }

  void setNotifications() async {
    // List<CanchaInfo> favorites = await ApiClient().getMyFavorites();

    setState(() {
      data = [
        Notificacion(
          author: 'Esclender',
          reason: 'Realizo un comentario',
          time: 'Hace 5 minutos',
          section: 'Tus canchas',
          isNew: true,
          route: 1,
        ),
        Notificacion(
          author: 'Grassport Team',
          reason: 'Reviso un reporte',
          time: 'Hace 5 minutos',
          section: 'Reportes',
          isNew: false,
          route: 0,
        ),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    //var listSaved = context.watch<SavedLocations>().state;

    return ListView.separated(
      itemCount: data.length, //listSaved.length
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemBuilder: (context, ind) {
        Notificacion notif = data[ind];

        return InkWell(
          onTap: () {
            switch (notif.route) {
              case 0:
                Navigator.pushNamed(context, routeReportDetailed);
                break;
              default:
            }
          },
          child: ListTile(
            leading: Icon(
              Icons.notifications,
              color: notif.isNew ? c8 : c11,
            ),
            title: RichText(
              text: TextSpan(
                text: notif.author,
                style: TextStyle(
                    color: notif.isNew ? c8 : c11, fontWeight: FontWeight.bold),
                children: <InlineSpan>[
                  TextSpan(
                      text: ' ${notif.reason}',
                      style: TextStyle(fontWeight: FontWeight.w300)),
                ],
              ),
            ),
            subtitle: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notif.section,
                  style: TextStyle(color: c16, fontWeight: FontWeight.bold),
                ),
                const Gap(8),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Row(
                    children: [
                      CircleShape(
                        color: c16.withOpacity(0.8),
                        height: 5,
                        width: 5,
                      ),
                      const Gap(8),
                      Text(
                        'Hace 5 minutos',
                        style: TextStyle(color: c16, fontSize: 12),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
