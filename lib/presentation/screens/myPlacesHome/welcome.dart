import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grassport_app/presentation/bloc/charge/bloc.dart';
import 'package:grassport_app/presentation/router/starting_app_routes.dart';
import 'package:grassport_app/presentation/screens/myPlacesHome/myplace_canchas.dart';
import 'package:grassport_app/presentation/screens/myPlacesHome/myplace_dashboard.dart';
import 'package:grassport_app/presentation/screens/myPlacesHome/myplace_posting_view.dart';
import 'package:grassport_app/presentation/styles/colors.dart';
import 'package:grassport_app/presentation/styles/systemThemes.dart';

class MyPlaceWelcomeScreen extends StatefulWidget {
  const MyPlaceWelcomeScreen({super.key});

  @override
  _MyPlaceWelcomeScreenState createState() => _MyPlaceWelcomeScreenState();
}

class _MyPlaceWelcomeScreenState extends State<MyPlaceWelcomeScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  final String userName = 'John Doe';
  final String userImageUrl =
      'https://firebasestorage.googleapis.com/v0/b/grassportapp-7ccb1.appspot.com/o/profile-ddefault.png?alt=media&token=36401350-8ef2-4483-b277-c3a17461e780';

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    context.read<ChargeRoute>().changeRoute(routeHomeApp);

    return AnnotatedRegion(
      value: SystemModifiers.overlayDark,
      child: Scaffold(
        backgroundColor: c8,
        body: _buildBody(),
        bottomNavigationBar: CircularNavigationBar(
          items: [
            CircularNavigationBarItem(icon: Icons.home, label: 'Home'),
            CircularNavigationBarItem(
                icon: Icons.sports_soccer, label: 'Tus canchas'),
            CircularNavigationBarItem(icon: Icons.add, label: 'Publicar'),
          ],
          currentIndex: _currentIndex,
          onTap: (index) {
            _pageController.animateToPage(
              index,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }

  Widget _buildBody() {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        _buildHomeView(),
        _buildPostedCanchasView(),
        _buildProfileView(),
      ],
    );
  }

  Widget _buildHomeView() {
    return DashboardMyPlaces();
  }

  Widget _buildPostedCanchasView() {
    return UserPostedCanchasWidget();
  }

  Widget _buildProfileView() {
    return LocationPostingView();
  }
}

class CircularNavigationBar extends StatelessWidget {
  final List<CircularNavigationBarItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  CircularNavigationBar({
    required this.items,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: 200, // Adjust the width as needed
      height: 70, // Adjust the height as needed
      decoration: BoxDecoration(
        color: Colors.transparent, // Customize the background color
        borderRadius: BorderRadius.circular(10), // Make it circular
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          items.length,
          (index) => CircularNavigationBarItemWidget(
            item: items[index],
            isSelected: index == currentIndex,
            onTap: () => onTap(index),
          ),
        ),
      ),
    );
  }
}

class CircularNavigationBarItem {
  final IconData icon;
  final String label;

  CircularNavigationBarItem({
    required this.icon,
    required this.label,
  });
}

class CircularNavigationBarItemWidget extends StatelessWidget {
  final CircularNavigationBarItem item;
  final bool isSelected;
  final VoidCallback onTap;

  CircularNavigationBarItemWidget({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        child: isSelected
            ? ElevatedButton.icon(
                onPressed: onTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isSelected ? c1 : c8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                icon: Icon(
                  item.icon,
                  color: isSelected ? c8 : c1,
                  size: 24,
                ),
                label: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  width: isSelected ? 80 : 0, // Adjust width as needed
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: Offset(1, 0),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                        curve: Curves.easeInOut,
                        parent: AlwaysStoppedAnimation(1),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        isSelected ? item.label : '',
                        style: TextStyle(
                          color: c8,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : IconButton(
                onPressed: onTap,
                icon: Icon(
                  item.icon,
                  color: c1.withOpacity(0.7),
                  size: 24,
                ),
              ),
      ),
    );
  }
}
