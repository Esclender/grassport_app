import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grassport_app/presentation/bloc/device_current_location/blocs.dart';
import 'package:grassport_app/services/location_ask.dart';

// ignore: must_be_immutable
class GoogleMapBig extends StatefulWidget {
  GoogleMapBig({super.key, this.isGps = true});

  bool isGps;

  @override
  State<GoogleMapBig> createState() => _GoogleMapBigState();
}

class _GoogleMapBigState extends State<GoogleMapBig> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  LatLng? currentLocation;

  //Set<Marker> _markers = Set();

  @override
  void initState() {
    if (widget.isGps) {
      checkPermissions();
      _liveLocation();
    } else {
      _definedLocation();
    }

    addCustomIcon();
    super.initState();
  }

  void checkPermissions() async {
    BuildContext c = context;
    var location = await checkIsGpsEnabled(context: c);
    LatLng data = LatLng(location.latitude, location.longitude);
    // ignore: use_build_context_synchronously
    var loc = c.read<DeviceGpsLocation>();
    loc.setGpsLocation(data);

    setState(() {
      currentLocation = data;
    });
  }

  void addCustomIcon() {
    BitmapDescriptor.fromAssetImage(const ImageConfiguration(),
            "assets/app_icons/Current_Location_Marker.png")
        .then(
      (icon) {
        setState(() {
          markerIcon = icon;
        });
      },
    );
  }

  //LISTEN
  void _liveLocation() {
    LocationSettings locationSettings = AndroidSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 0,
      intervalDuration: const Duration(seconds: 100),
    );

    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      LatLng actualLoc = LatLng(position.latitude, position.longitude);

      BuildContext c = context;
      c.read<DeviceGpsLocation>().setGpsLocation(actualLoc);

      setState(() {
        currentLocation = actualLoc;
      });
    });
  }

  //USE LOCATION PROVIDED
  void _definedLocation() {
    BuildContext c = context;

    LatLng? definedLocation = c.read<DeviceGpsLocation>().state;

    setState(() {
      currentLocation = definedLocation;
    });
  }

  @override
  Widget build(BuildContext context) {
    return currentLocation != null
        ? GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: currentLocation as LatLng,
              zoom: 14.4746,
            ),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: {
              Marker(
                markerId: const MarkerId("Posicion"),
                position: LatLng(currentLocation?.latitude as double,
                    currentLocation?.longitude as double),
                icon: markerIcon,
              ), // Marker
            },
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}
