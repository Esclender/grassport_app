import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grassport_app/api/api_client.dart';
import 'package:grassport_app/models/cancha_info.dart';
import 'package:grassport_app/presentation/bloc/google_map_markers/bloc.dart';
import 'package:grassport_app/presentation/bloc/home_view_selected/bloc.dart';

// ignore: must_be_immutable
class SavedList extends StatefulWidget {
  Icon icon = const Icon(Icons.bookmark);

  SavedList({super.key});

  @override
  State<SavedList> createState() => _SavedListState();
}

class _SavedListState extends State<SavedList> {
  List<CanchaInfo> data = [];

  @override
  void initState() {
    setFavorites();
    super.initState();
  }

  void setFavorites() async {
    List<CanchaInfo> favorites = await ApiClient().getMyFavorites();

    setState(() {
      data = favorites;
    });
  }

  @override
  Widget build(BuildContext context) {
    //var listSaved = context.watch<SavedLocations>().state;

    return ListView.separated(
      itemCount: data.length, //listSaved.length
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemBuilder: (context, ind) {
        return SavedOne(
          icon: widget.icon,
          title: data[ind].nombre,
          direccion: data[ind].address,
          location: data[ind].location,
          placeId: data[ind].placeId,
        );
      },
    );
  }
}

// ignore: must_be_immutable
class SavedOne extends StatelessWidget {
  String title;
  String direccion;
  String placeId;
  LatLng location;
  Icon icon;

  SavedOne({
    super.key,
    this.title = "",
    this.direccion = "",
    required this.placeId,
    required this.icon,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    HomeView selectedIcon = context.watch<HomeView>();

    return InkWell(
      onTap: () {
        CanchaMarker data = CanchaMarker(
          nombre: title,
          location: location,
          placeId: placeId,
          rating: 0,
          address: direccion,
        );

        context.read<GoogleMapMarkers>().setSingleMarker(data);

        Navigator.pop(context);
        selectedIcon.changeView(0);
      },
      child: ListTile(
        leading: icon,
        title: Text(title),
        subtitle: Text(direccion),
      ),
    );
  }
}
