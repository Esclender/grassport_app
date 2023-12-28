import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grassport_app/presentation/bloc/home_view_selected/bloc.dart';
import 'package:grassport_app/presentation/components/fav_notif_list.dart';

class FavView extends StatefulWidget {
  const FavView({super.key});

  @override
  State<FavView> createState() => _FavViewState();
}

class _FavViewState extends State<FavView> {
  @override
  Widget build(BuildContext context) {
    HomeView selectedIcon = context.watch<HomeView>();

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
        title: const Text("Guardados"),
        centerTitle: true,
      ),
      body: SavedList(),
    );
  }
}
