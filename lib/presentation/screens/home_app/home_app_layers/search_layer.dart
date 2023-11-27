import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grassport_app/presentation/bloc/home_is_search/bloc.dart';
import 'package:grassport_app/presentation/bloc/locations/blocs.dart';
import 'package:grassport_app/presentation/components/location_search_list.dart';
import 'package:grassport_app/presentation/styles/colors.dart';

class HomeSearchList extends StatefulWidget {
  const HomeSearchList({super.key});

  @override
  State<HomeSearchList> createState() => _HomeSearchListState();
}

class _HomeSearchListState extends State<HomeSearchList> {
  @override
  Widget build(BuildContext context) {
    IsSearch showTopScreen = context.watch<IsSearch>();

    return AnimatedPositioned(
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 200),
      top: showTopScreen.state ? 0 : -MediaQuery.of(context).size.height,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeIn,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: const HomeList(),
      ),
    );
  }
}

class HomeList extends StatefulWidget {
  const HomeList({super.key});

  @override
  State<HomeList> createState() => _HomeListState();
}

class _HomeListState extends State<HomeList> {
  late List registros = [];

  // @override
  // void initState() {
  //   setRegistros();
  //   super.initState();
  // }

  void setRegistros() {
    setState(() async {
      registros = await context.watch<SelectLocation>().getRegistros();
    });
  }

  @override
  Widget build(BuildContext context) {
    IsSearch showTopScreen = context.watch<IsSearch>();
    final locationData = context.read<SelectLocation>();

    return Opacity(
      opacity: showTopScreen.state ? 1.0 : 0.0,
      child: Material(
        child: AnimatedContainer(
          margin: const EdgeInsets.only(top: 100, bottom: 100),
          height: MediaQuery.of(context).size.height * .70,
          duration: const Duration(milliseconds: 2000),
          color: c1,
          child: Searching(
            historyData: locationData,
            registros: registros,
          ),
        ),
      ),
    );
  }
}
