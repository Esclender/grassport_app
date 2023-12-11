import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grassport_app/presentation/bloc/loged_user_data/bloc.dart';
import 'package:grassport_app/presentation/router/starting_app_routes.dart';
import 'package:grassport_app/presentation/screens/home_app/admin_views/admin_panel.dart';
import 'package:grassport_app/presentation/screens/home_app/admin_views/reports_view.dart';
import 'package:grassport_app/presentation/screens/home_app/admin_views/users_registered.dart';
import 'package:grassport_app/presentation/styles/colors.dart';
import 'package:grassport_app/presentation/styles/systemThemes.dart';
import 'package:grassport_app/services/auth_login.dart';

class AdminView extends StatefulWidget {
  const AdminView({Key? key}) : super(key: key);

  @override
  _AdminViewState createState() => _AdminViewState();
}

class _AdminViewState extends State<AdminView> {
  int _selectedTabIndex = 0;
  bool _isLeftBarVisible = true;

  @override
  Widget build(BuildContext context) {
    double leftBarWidth = 80.0;
    double hamburgerButtonWidth = 60.0;

    List<Widget> _contentWidgets = [
      SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: AdminPanelView(),
      ),
      SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: UserListScreen(),
      ),
      SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ReportView(),
      ),
    ];

    return AnnotatedRegion(
      value: SystemModifiers.overlayDarkAdmin,
      child: Scaffold(
        body: Stack(
          children: [
            // Gradient Background
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.green[900]!, // Dark Green
                    Colors.green[600]!, // Medium Green
                    Colors.green[300]!, // Light Green
                    Colors.green[800]!, // Dark Green
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(
                // Use Stack to position the image absolutely
                children: [
                  Positioned(
                    top: -40,
                    right: -40,
                    child: Opacity(
                      opacity: 0.5,
                      child: Image.asset(
                        'assets/images/Logo.png',
                        fit: BoxFit.cover, // Adjust opacity as needed
                        colorBlendMode: BlendMode.darken,
                      ),
                    ),
                  ),
                  // ... (remaining code)
                ],
              ),
            ),
            // Main Content
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              left: _isLeftBarVisible ? leftBarWidth : 0.0,
              child: SizedBox(
                width: _isLeftBarVisible
                    ? MediaQuery.of(context).size.width - leftBarWidth
                    : MediaQuery.of(context).size.width,
                child: SizedBox(
                  child: _contentWidgets[_selectedTabIndex],
                ),
              ),
            ),
            // Left Bar
            Positioned(
              top: 0,
              bottom: 0,
              left: _isLeftBarVisible ? 0.0 : -leftBarWidth,
              child: Container(
                width: leftBarWidth,
                decoration: BoxDecoration(
                  color: c19, // Dark green background
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(_isLeftBarVisible ? 20.0 : 0.0),
                    bottomRight: Radius.circular(20.0),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Hide Button
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isLeftBarVisible = !_isLeftBarVisible;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 15.0),
                        width: leftBarWidth,
                        height: 60.0,
                        decoration: BoxDecoration(
                          color: c19,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(20.0),
                          ),
                        ),
                        child: const Icon(
                          Icons.keyboard_arrow_left,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                    ),
                    Spacer(),
                    buildFloatingButton(0, leftBarWidth),
                    buildFloatingButton(1, leftBarWidth),
                    buildFloatingButton(2, leftBarWidth),
                    Spacer(),
                    GestureDetector(
                      onTap: () async {
                        Navigator.pushNamed(context, routeLogin);
                        await logOutWithGoogle();
                        // ignore: use_build_context_synchronously
                        context.read<LoggedUser>().setData(null);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 15.0),
                        width: leftBarWidth,
                        height: 60.0,
                        decoration: BoxDecoration(
                          color: c19,
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(20.0),
                          ),
                        ),
                        child: const Icon(
                          Icons.logout,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Hamburger Button (Hidden when left bar is visible)
            if (!_isLeftBarVisible)
              Positioned(
                top: 0,
                left: _isLeftBarVisible ? leftBarWidth : 0.0,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isLeftBarVisible = true;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 18.0),
                    width: hamburgerButtonWidth,
                    height: 60.0,
                    child: const Padding(
                      padding: EdgeInsets.only(top: 15.0, left: 5.0),
                      child: Icon(
                        Icons.menu_outlined,
                        color: Colors.white,
                        size: 35,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildFloatingButton(int index, double buttonWidth) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTabIndex = index;
        });
      },
      child: Container(
        width: buttonWidth,
        height: 60.0,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: _selectedTabIndex == index
                  ? Colors.greenAccent.withOpacity(0.7)
                  : Colors.transparent,
              spreadRadius: 2.0,
              blurRadius: 8.0,
              offset: const Offset(0, 0),
            ),
          ],
          color: c19,
        ),
        child: Icon(
          _getIconForIndex(index),
          color: Colors.white,
        ),
      ),
    );
  }

  IconData _getIconForIndex(int index) {
    switch (index) {
      case 0:
        return Icons.dashboard;
      case 1:
        return Icons.people;
      case 2:
        return Icons.report;
      default:
        return Icons.dashboard;
    }
  }
}
