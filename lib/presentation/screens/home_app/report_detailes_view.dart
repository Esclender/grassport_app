import 'package:flutter/material.dart';
import 'package:grassport_app/models/report_model.dart';
import 'package:grassport_app/presentation/styles/colors.dart';

class ReportDetailedWidget extends StatefulWidget {
  final ReportInfo dataReport;
  const ReportDetailedWidget({
    super.key,
    required this.dataReport,
  });

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
              leading: const CircleAvatar(
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
            Text(widget.dataReport.comment),
          ],
        ),
      ),
    );
  }
}
