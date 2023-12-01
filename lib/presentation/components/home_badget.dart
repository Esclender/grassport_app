import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grassport_app/presentation/bloc/home_is_search/bloc.dart';
import 'package:grassport_app/presentation/bloc/home_view_selected/bloc.dart';
import 'package:grassport_app/presentation/components/popus/must_be_logged_pp.dart';
import 'package:grassport_app/presentation/router/starting_app_routes.dart';
import 'package:grassport_app/presentation/styles/colors.dart';
import 'package:grassport_app/services/auth_login.dart';

// ignore: must_be_immutable
class HomeBadget extends StatefulWidget {
  const HomeBadget({super.key});

  @override
  State<HomeBadget> createState() => _HomeBadgetState();
}

class _HomeBadgetState extends State<HomeBadget> {
  //int selectedIcon = 0;

  @override
  Widget build(BuildContext context) {
    IsSearch showTopScreen = context.watch<IsSearch>();
    HomeView selectedIcon = context.watch<HomeView>();

    return Container(
      width: 220,
      height: 40,
      decoration: BoxDecoration(
        color: c8,
        borderRadius: BorderRadius.circular(40.0),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(127, 0, 0, 0),
            offset: Offset(0, 0.7),
            blurRadius: 2,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              if (selectedIcon.state != 0) {
                setState(() {
                  selectedIcon.changeView(0);
                });
                Navigator.pop(context);
              }
              showTopScreen.toggleSearch(false);
            },
            icon: selectedIcon.state == 0
                ? const Icon(
                    Icons.home_rounded,
                    color: Colors.white,
                  )
                : const Icon(
                    Icons.home_outlined,
                    color: Colors.white,
                  ),
          ),
          IconButton(
            onPressed: () async {
              bool isUserSigned = await checkIfUserIsSignedIn(context);
              if (isUserSigned && selectedIcon.state != 1) {
                // ignore: use_build_context_synchronously
                if (selectedIcon.state != 0) Navigator.pop(context);
                setState(() {
                  selectedIcon.changeView(1);
                });
                // ignore: use_build_context_synchronously
                Navigator.pushNamed(context, routeFavView);
              } else {
                // ignore: use_build_context_synchronously
                showDialog(
                  barrierColor: Colors.transparent,
                  context: context,
                  builder: (context) => MustBeLoggedPopup(),
                );
              }
            },
            icon: selectedIcon.state == 1
                ? const Icon(
                    Icons.bookmark,
                    color: Colors.white,
                  )
                : const Icon(
                    Icons.bookmark_border,
                    color: Colors.white,
                  ),
          ),
          IconButton(
            onPressed: () async {
              bool isUserSigned = await checkIfUserIsSignedIn(context);
              if (isUserSigned && selectedIcon.state != 2) {
                // ignore: use_build_context_synchronously
                if (selectedIcon.state != 0) Navigator.pop(context);
                setState(() {
                  selectedIcon.changeView(2);
                });
                // ignore: use_build_context_synchronously
                Navigator.pushNamed(context, routeNotifView);
              } else {
                // ignore: use_build_context_synchronously
                showDialog(
                  barrierColor: Colors.transparent,
                  context: context,
                  builder: (context) => MustBeLoggedPopup(),
                );
              }
            },
            icon: selectedIcon.state == 2
                ? const Icon(
                    Icons.notifications,
                    color: Colors.white,
                  )
                : const Icon(
                    Icons.notifications_none_outlined,
                    color: Colors.white,
                  ),
          ),
        ],
      ),
    );
  }
}
