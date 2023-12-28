import 'package:flutter/material.dart';
import 'package:grassport_app/presentation/styles/colors.dart';

class ReportDetailedWidget extends StatefulWidget {
  const ReportDetailedWidget({super.key});

  @override
  State<ReportDetailedWidget> createState() => _ReportDetailedWidgetState();
}

class _ReportDetailedWidgetState extends State<ReportDetailedWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://firebasestorage.googleapis.com/v0/b/grassportapp-7ccb1.appspot.com/o/profile-ddefault.png?alt=media&token=36401350-8ef2-4483-b277-c3a17461e780'),
              ),
              title: Text(
                'Grassport Team',
                style: TextStyle(color: c11, fontWeight: FontWeight.bold),
              ),
              subtitle: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ' Revision de reporte',
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
            Text(
              'Sint reprehenderit non cillum qui duis id fugiat amet id nisi reprehenderit. Aliqua pariatur magna laboris fugiat nostrud. Excepteur ipsum minim mollit nostrud.\nIncididunt cupidatat voluptate aliquip qui incididunt tempor aliquip cillum qui nisi ea. Cupidatat et amet anim elit incididunt irure. Ut elit dolor laboris ut aute aliquip sint ea nisi est irure et. Sint do proident voluptate consequat enim non aliquip deserunt.\n Velit cillum aliquip duis nostrud excepteur ex ad eiusmod enim non nostrud. Magna ullamco quis ex commodo non voluptate ipsum do et aute cillum sint laborum commodo. Laborum ut exercitation id ea nisi elit.Id est aute qui elit. Proident enim et ipsum excepteur. Officia deserunt laboris adipisicing anim quis tempor aliqua eiusmod Lorem cillum consectetur.',
            ),
          ],
        ),
      ),
    );
  }
}
