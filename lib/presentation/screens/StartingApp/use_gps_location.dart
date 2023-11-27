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
          GoogleMapBig(),
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 170,
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
                title: localityName == "No defined"
                    ? const Padding(
                        padding: EdgeInsets.only(right: 140.0),
                        child: ShimmeringBackground(),
                      )
                    : Text(
                        localityName,
                        style: TextStyle(color: c9),
                      ),
                subtitle: streetName == "No defined"
                    ? const Padding(
                        padding: EdgeInsets.only(right: 100.0, top: 5.0),
                        child: ShimmeringBackground(),
                      )
                    : Text(
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

// ignore: must_be_immutable
class ShimmeringBackground extends StatefulWidget {
  const ShimmeringBackground({super.key});

  @override
  _ShimmeringBackgroundState createState() => _ShimmeringBackgroundState();
}

class _ShimmeringBackgroundState extends State<ShimmeringBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = Tween<double>(
      begin: -2.0,
      end: 1.0,
    ).animate(_controller);

    _controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            gradient: LinearGradient(
              colors: const [
                Color.fromARGB(142, 185, 182, 182),
                Color.fromARGB(145, 178, 176, 176),
                Color(0xffffffff),
              ],
              begin: Alignment(_animation.value, -1.0),
              end: Alignment(_animation.value + 3.0, 2.0),
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

/**
 * ListTile(
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
 */