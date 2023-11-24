import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grassport_app/api/api_client.dart';
import 'package:grassport_app/presentation/bloc/charge/bloc.dart';
import 'package:grassport_app/presentation/bloc/device_current_location/blocs.dart';
import 'package:grassport_app/presentation/components/buttons.dart';
import 'package:grassport_app/presentation/components/google_map.dart';
import 'package:grassport_app/presentation/router/starting_app_routes.dart';
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
        alignment: AlignmentDirectional.center,
        children: [
          const GoogleMapBig(),
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

class ConfirmLocation extends StatefulWidget {
  const ConfirmLocation(
      {super.key}); //List<Placemark> placemarks = await placemarkFromCoordinates(52.2165157, 6.9437819);

  @override
  State<ConfirmLocation> createState() => _ConfirmLocationState();
}

class _ConfirmLocationState extends State<ConfirmLocation> {
  late LatLng? dataLocation;
  late String streetName = "No defined";
  late String localityName = "No defined";

  @override
  @protected
  @mustCallSuper
  void didChangeDependencies() {
    super.didChangeDependencies();

    getPlaceMarks();
  }

  void getPlaceMarks() async {
    dataLocation = context.watch<DeviceGpsLocation>().state;

    if (dataLocation != null) {
      final resp = await ApiClient().reverseCode(
          lat: dataLocation?.latitude, lon: dataLocation?.longitude);

      setState(() {
        streetName = resp["response"]["street"] == null
            ? "No defined"
            : resp["response"]["street"] as String;
        localityName = resp["response"]["locality"] == null
            ? "No defined"
            : resp["response"]["locality"] as String;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    context.read<ChargeRoute>().changeRoute(routeHomeApp);
    return dataLocation != null
        ? ListView(
            children: [
              ListTile(
                leading: const Icon(Icons.location_pin),
                title: Text(
                  localityName,
                  style: TextStyle(color: c9),
                ),
                subtitle: Text(
                  streetName,
                  style: TextStyle(color: c10),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: CustomButton(
                  next: () {
                    Navigator.pushNamed(context, routeCharge);
                  },
                  text: Text(
                    "Confirmar ubicacion",
                    style: TextStyle(color: c1),
                  ),
                  bg: c8,
                ),
              )
            ],
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}
