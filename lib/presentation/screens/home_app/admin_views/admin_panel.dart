import 'package:flutter/material.dart';
import 'package:grassport_app/presentation/components/bars_graphic.dart';
import 'package:grassport_app/presentation/styles/colors.dart';

class AdminPanel {
  final String adminName;
  final String adminEmail;
  final String photoURL;
  final int totalUsers;
  final int totalReports;
  final int totalReportsOfWeek;

  AdminPanel({
    required this.adminName,
    required this.adminEmail,
    required this.photoURL,
    required this.totalUsers,
    required this.totalReports,
    required this.totalReportsOfWeek,
  });
}

class AdminPanelView extends StatefulWidget {
  const AdminPanelView({Key? key}) : super(key: key);

  @override
  _AdminPanelViewState createState() => _AdminPanelViewState();
}

class _AdminPanelViewState extends State<AdminPanelView> {
  final AdminPanel adminPanel = AdminPanel(
    adminName: 'Esclender',
    adminEmail: 'admin@example.com',
    photoURL:
        'https://firebasestorage.googleapis.com/v0/b/grassportapp-7ccb1.appspot.com/o/profile-ddefault.png?alt=media&token=36401350-8ef2-4483-b277-c3a17461e780', // Replace with actual URL
    totalUsers: 100,
    totalReports: 500,
    totalReportsOfWeek: 50,
  );

  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgets = [
      _buildWrap(),
      BarGraphic(),
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text(
          'Panel Admin',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(adminPanel.photoURL),
                ),
                const SizedBox(height: 16),
                Text(
                  'Bienvenido ${adminPanel.adminName}',
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold, color: c1),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.65,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _widgets.length,
                    itemBuilder: (context, index) {
                      return _widgets[index];
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWrap() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Wrap(
        alignment: WrapAlignment.center,
        direction: Axis.horizontal,
        spacing: 16.0,
        runSpacing: 16.0,
        children: [
          _buildCircularStat(
            context,
            'Total usuarios',
            adminPanel.totalUsers,
          ),
          _buildCircularStat(
            context,
            'Total Reportes',
            adminPanel.totalReports,
          ),
          _buildCircularStat(
            context,
            'Reportes \nde la semana',
            adminPanel.totalReportsOfWeek,
          ),
        ],
      ),
    );
  }

  Widget _buildCircularStat(BuildContext context, label, int value) {
    return Container(
      width: 0.38 * MediaQuery.of(context).size.width,
      height: 0.38 * MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: c8,
        border: Border.all(color: c1, width: 2.0),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.query_stats,
              color: Colors.white,
            ),
            Text(
              value.toString(),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 0.06 * MediaQuery.of(context).size.width,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: 0.28 * MediaQuery.of(context).size.width,
              child: Text(
                label,
                style: const TextStyle(fontSize: 14, color: Colors.white),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
