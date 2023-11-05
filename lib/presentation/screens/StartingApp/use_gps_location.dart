import 'dart:async';

import 'package:flutter/material.dart';
import 'package:grassport_app/presentation/components/buttons.dart';
import 'package:grassport_app/presentation/components/popus/activate_gps.dart';
import 'package:grassport_app/presentation/styles/colors.dart';

class CurrentLocationByGps extends StatefulWidget {
  const CurrentLocationByGps({super.key});

  @override
  State<CurrentLocationByGps> createState() => _CurrentLocationByGpsState();
}

class _CurrentLocationByGpsState extends State<CurrentLocationByGps> {
  //INITIALIZE THE INIT STATE AND CALL DE DIALOG IN THAT MOMENT

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer(const Duration(seconds: 1), () {
        showDialog(context: context, builder: (context) => const ActivateGps());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        backgroundColor: c1,
        child: const Icon(Icons.arrow_back),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              "assets/images/Street_bg.png",
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 140,
              decoration: BoxDecoration(
                color: c1,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: const ConfirmLocation(),
            ),
          )
        ],
      ),
    );
  }
}

class ConfirmLocation extends StatelessWidget {
  const ConfirmLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.location_pin),
          title: Text(
            "Independecia",
            style: TextStyle(color: c9),
          ),
          subtitle: Text(
            "Independecia,Lima,Peru",
            style: TextStyle(color: c10),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: CustomButton(
            next: () {},
            text: Text(
              "Confirmar ubicacion",
              style: TextStyle(color: c1),
            ),
            bg: c8,
          ),
        )
      ],
    );
  }
}
