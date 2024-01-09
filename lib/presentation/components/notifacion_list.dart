import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:grassport_app/models/notification_model.dart';
import 'package:grassport_app/presentation/bloc/notifications/bloc.dart';
import 'package:grassport_app/presentation/components/shapes.dart';
import 'package:grassport_app/presentation/styles/colors.dart';

// ignore: must_be_immutable
class NotificationList extends StatefulWidget {
  NotificationList({super.key});

  @override
  State<NotificationList> createState() => _SavedListState();
}

class _SavedListState extends State<NotificationList> {
  @override
  Widget build(BuildContext context) {
    //var listSaved = context.watch<SavedLocations>().state;

    NotificationsScaffold data = context.watch<Notifications>().state!;

    return ListView.separated(
      itemCount: data.allNotifications.length, //listSaved.length
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemBuilder: (context, ind) {
        Notificacion notif = data.allNotifications[ind];

        return InkWell(
          onTap: () {
            notif.goToRoute(context);
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
              crossAxisAlignment: CrossAxisAlignment.end,
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
                        data.allNotifications[ind].time,
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
