import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grassport_app/models/cancha_info.dart';
import 'package:grassport_app/presentation/bloc/home_view_selected/bloc.dart';
import 'package:grassport_app/presentation/bloc/savedLocations/blocs.dart';
import 'package:grassport_app/presentation/components/fav_notif_list.dart';
import 'package:grassport_app/presentation/components/home_badget.dart';

class FavView extends StatefulWidget {
  const FavView({super.key});

  @override
  State<FavView> createState() => _FavViewState();
}

class _FavViewState extends State<FavView> {
  @override
  Widget build(BuildContext context) {
    HomeView selectedIcon = context.watch<HomeView>();
    List<CanchaInfo> listSaved = context.watch<SavedLocations>().state;

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            selectedIcon.changeView(0);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Padding(
          padding:
              EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.2),
          child: const Text("Guardados"),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: SavedList(
              data: listSaved,
              icon: const Icon(Icons.bookmark),
            ),
          ),
          Positioned(
            bottom: 50,
            left: MediaQuery.of(context).size.width * 0.23,
            child: const HomeBadget(),
          ),
        ],
      ),
    );
  }
}
