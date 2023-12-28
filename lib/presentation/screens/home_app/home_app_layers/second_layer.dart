import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grassport_app/models/logged_user.dart';
import 'package:grassport_app/presentation/bloc/google_map_markers/bloc.dart';
import 'package:grassport_app/presentation/bloc/home_is_search/bloc.dart';
import 'package:grassport_app/presentation/bloc/loged_user_data/bloc.dart';
import 'package:grassport_app/presentation/components/popus/profile_home_pp.dart';
import 'package:grassport_app/presentation/router/starting_app_routes.dart';
import 'package:grassport_app/presentation/styles/colors.dart';

// ignore: must_be_immutable
class SecondLayer extends StatefulWidget {
  const SecondLayer({super.key});

  @override
  State<SecondLayer> createState() => _SecondLayerState();
}

class _SecondLayerState extends State<SecondLayer> {
  final TextEditingController _searchController = TextEditingController();

  void searchCanchas({search}) async {
    final locationData = context.read<CanchasByInout>();
    await locationData.getCanchasByInput(query: search);
  }

  @override
  Widget build(BuildContext context) {
    UserDisplayed? isSigned = context.watch<LoggedUser>().state;
    IsSearch toggle = context.watch<IsSearch>();

    return BlocBuilder<IsSearch, bool>(
      builder: (builder, showTopScreen) {
        return Stack(
          children: [
            Row(
              mainAxisAlignment: showTopScreen
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: SearchBar(
                    controller: _searchController,
                    onTap: () {
                      toggle.toggleSearch(true);
                    },
                    hintText: "Buscar canchas",
                    hintStyle: MaterialStateProperty.all(
                      const TextStyle(
                          color: Color.fromARGB(141, 158, 158, 158)),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(c1),
                    elevation: MaterialStateProperty.all(1.0),
                    constraints: BoxConstraints(
                        maxWidth: showTopScreen ? 350 : 300, minHeight: 50),
                    leading: const Icon(Icons.search),
                    onSubmitted: (e) {
                      searchCanchas(search: e);
                      _searchController.clear();
                    },
                  ),
                ),
                isSigned != null
                    ? showTopScreen
                        ? const Offstage()
                        : const Avatar()
                    : showTopScreen
                        ? const Offstage()
                        : const AvatarUserNotLogged(),
              ],
            )
          ],
        );
      },
    );
  }
}

class Avatar extends StatelessWidget {
  const Avatar({super.key});

  @override
  Widget build(BuildContext context) {
    UserDisplayed? userData = context.watch<LoggedUser>().state;

    return Padding(
      padding: const EdgeInsets.only(top: 60),
      child: GestureDetector(
        onTap: () {
          showDialog(
              context: context, builder: (context) => const ProfilePopup());
        },
        child: Container(
          decoration: BoxDecoration(
            color: c8,
            borderRadius: BorderRadius.circular(50.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: CircleAvatar(
              radius: 15.0,
              backgroundColor: c1,
              backgroundImage: NetworkImage(userData?.photoURL as String),
            ),
          ),
        ),
      ),
    );
  }
}

class AvatarUserNotLogged extends StatelessWidget {
  const AvatarUserNotLogged({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60),
      child: GestureDetector(
        onTap: () {
          context.read<GoogleMapMarkers>().clear();
          Navigator.pushNamed(context, routeLogin);
        },
        child: Container(
          decoration: BoxDecoration(
            color: c8,
            borderRadius: BorderRadius.circular(50.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: CircleAvatar(
              radius: 15.0,
              backgroundColor: c1,
              child: Icon(
                Icons.exit_to_app,
                color: c8,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
