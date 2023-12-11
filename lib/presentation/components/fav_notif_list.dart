import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:grassport_app/api/api_client.dart';
import 'package:grassport_app/models/cancha_info.dart';

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
        if (ind == data.length - 1) {
          return Column(
            children: [
              SavedOne(
                icon: widget.icon,
                title: data[ind].nombre,
                direccion: data[ind].address,
              ),
              const Gap(100),
            ],
          );
        } else {
          return SavedOne(
            icon: widget.icon,
            title: data[ind].nombre,
            direccion: data[ind].address,
          );
        }
      },
    );
  }
}

// ignore: must_be_immutable
class SavedOne extends StatelessWidget {
  String title;
  String direccion;
  Icon icon;

  SavedOne(
      {super.key, this.title = "", this.direccion = "", required this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: ListTile(
        leading: icon,
        title: Text(title),
        subtitle: Text(direccion),
      ),
    );
  }
}
