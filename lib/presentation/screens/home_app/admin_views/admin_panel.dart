import 'package:flutter/material.dart';
import 'package:grassport_app/api/api_client.dart';
import 'package:grassport_app/models/admin_panel_model.dart';
import 'package:grassport_app/models/bar_graphic_model.dart';
import 'package:grassport_app/presentation/components/bars_graphic.dart';
import 'package:grassport_app/presentation/styles/colors.dart';

class AdminPanelView extends StatefulWidget {
  const AdminPanelView({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AdminPanelViewState createState() => _AdminPanelViewState();
}

class _AdminPanelViewState extends State<AdminPanelView> {
  AdminPanel? adminPanel;
  late PageController _pageController;

  final ApiClient _myClient = ApiClient();

  @override
  void initState() {
    setDataPanel();

    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void setDataPanel() async {
    AdminPanel data = await _myClient.getAdminPanel();

    setState(() {
      adminPanel = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (adminPanel == null) {
      return const Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    List<Widget> _widgets = [
      _buildWrap(),
      BarGraphic(
        dataList: adminPanel?.topUsers as List<BarData>,
        max: adminPanel?.maxPlusTen as double,
      ),
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
                  backgroundImage: NetworkImage(adminPanel?.photoURL as String),
                ),
                const SizedBox(height: 16),
                Text(
                  'Bienvenido ${adminPanel?.adminName as String}',
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
            adminPanel?.totalUsers as int,
          ),
          _buildCircularStat(
            context,
            'Total Reportes',
            adminPanel?.totalReports as int,
          ),
          _buildCircularStat(
            context,
            'Reportes \nde la semana',
            adminPanel?.totalReportsOfWeek as int,
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
