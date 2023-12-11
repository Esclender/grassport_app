// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:grassport_app/api/api_client.dart';
import 'package:grassport_app/models/report_model.dart';
import 'package:grassport_app/presentation/styles/colors.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ReportView extends StatefulWidget {
  const ReportView({super.key});

  @override
  _ReportViewState createState() => _ReportViewState();
}

class _ReportViewState extends State<ReportView> {
  ReportInfo? selectedReport;
  final ApiClient _myClient = ApiClient();

  List<ReportInfo>? reportData;

  @override
  void initState() {
    setReportData();

    super.initState();
  }

  void setReportData() async {
    List<ReportInfo> data = await _myClient.getAllReports();

    setState(() {
      reportData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (reportData == null) {
      return const Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (reportData != null) {
      if (reportData?.isEmpty as bool) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Text(
              'Sin reportes!',
              style: TextStyle(color: c1),
            ),
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Reportes',
          style: TextStyle(color: c1, fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Carousel of Cards
            SizedBox(
              height: 250.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: reportData?.length,
                itemBuilder: (context, index) {
                  return CardWidget(
                    color: c8,
                    report: reportData?[index] as ReportInfo,
                    onTap: () =>
                        _showCardDetails(reportData?[index] as ReportInfo),
                    borderRadius: BorderRadius.circular(10.0),
                  );
                },
              ),
            ),
            // Detailed View
            selectedReport != null
                ? DetailedView(report: selectedReport!)
                : Center(
                    child: Text(
                      'Selecciona un reporte',
                      style: TextStyle(color: c1),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  void _showCardDetails(ReportInfo report) {
    setState(() {
      selectedReport = report;
    });
  }
}

class CardWidget extends StatelessWidget {
  final ReportInfo report;
  final VoidCallback onTap;
  final Color color;
  final BorderRadius borderRadius;

  const CardWidget({
    required this.report,
    required this.onTap,
    this.color = Colors.white,
    this.borderRadius = BorderRadius.zero,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 150.0,
        child: Card(
          margin: const EdgeInsets.all(8.0),
          color: color,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.description, size: 40, color: c1),
                const SizedBox(height: 10),
                Text(
                  report.userName,
                  style: TextStyle(fontSize: 18.0, color: c1),
                ),
                const Gap(5),
                Text(
                  report.description,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14.0, color: c1),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DetailedView extends StatelessWidget {
  final ReportInfo report;

  const DetailedView({
    required this.report,
    Key? key,
  }) : super(key: key);

  void _showImageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: SizedBox(
            width: double.infinity,
            height: 400,
            child: PhotoViewGallery(
              pageController: PageController(),
              scrollPhysics: const BouncingScrollPhysics(),
              backgroundDecoration: const BoxDecoration(
                color: Colors.black,
              ),
              pageOptions: [
                PhotoViewGalleryPageOptions(
                  imageProvider: NetworkImage(report.imageUrl),
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.contained * 2.0,
                  heroAttributes: PhotoViewHeroAttributes(tag: report.imageUrl),
                ),
              ],
              enableRotation: false,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: c8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align text to start
        children: [
          GestureDetector(
            onDoubleTap: () => _showImageDialog(context),
            child: Container(
              height: 250,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20.0),
                  topLeft: Radius.circular(20.0),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20.0),
                  topLeft: Radius.circular(20.0),
                ),
                child: Image.network(
                  report.imageUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Align text to start
                  children: [
                    Text(
                      report.userName,
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        color: c1,
                      ),
                    ),
                    Text(
                      report.email,
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w100,
                        color: c17,
                      ),
                    ),
                    Text(
                      report.number,
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w100,
                        color: c17,
                      ),
                    ),
                  ],
                ),
                Text(
                  report.fechaCreacion,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w100,
                    color: c10,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 250,
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.0),
                topLeft: Radius.circular(20.0),
              ),
            ),
            child: ListView(
              children: [
                Text(
                  report.description,
                  style: TextStyle(fontSize: 16, color: c1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
