import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grassport_app/presentation/bloc/device_current_location/blocs.dart';
import 'package:grassport_app/presentation/bloc/google_map_markers/bloc.dart';
import 'package:grassport_app/presentation/bloc/nearCanchas/blocs.dart';
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
  LatLng? currentLocation;
  Set<Marker> markersNearCanchas = {};
  Marker myPosicion = const Marker(markerId: MarkerId('Posicion'));

  @override
  void initState() {
    if (widget.isGps) {
      checkPermissions();
      //_liveLocation();
    } else {
      _definedLocation();
      setMakers();
    }

    setMyPosicion();
    super.initState();
  }

  void updateFocusMap(latLng, markers) async {
    // Update the camera position to focus on the new marker
    if (markers.isNotEmpty) {
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newLatLng(latLng));
    }
  }

  void setMyPosicion({LatLng? posLocation}) async {
    BitmapDescriptor markerIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      "assets/app_icons/Current_Location_Marker.png",
    );

    setState(() {
      myPosicion = Marker(
        markerId: const MarkerId("Posicion"),
        position: LatLng(currentLocation?.latitude as double,
            currentLocation?.longitude as double),
        icon: markerIcon,
      );
    });
  }

  void setMakers() async {
    // ignore: use_build_context_synchronously
    Set<Marker> data = await context
        .read<NearCanchas>()
        .getNearCanchas(currentLocation: currentLocation);

    Future.delayed(const Duration(seconds: 2), () {
      showMarkerInfoWindow(data);
    });

    setState(() {
      markersNearCanchas = data;
    });
  }

  void showMarkerInfoWindow(Set<Marker> markers) async {
    if (_controller.isCompleted) {
      final GoogleMapController controller = await _controller.future;
      for (Marker marker in markers) {
        controller.showMarkerInfoWindow(marker.markerId);
      }
    }
  }

  void checkPermissions() async {
    BuildContext c = context;
    var location = await checkIsGpsEnabled(context: c);

    //TODO: MANAGE WHEN USE DOESN'T AGREE

    LatLng data = LatLng(location.latitude, location.longitude);
    // ignore: use_build_context_synchronously
    var loc = c.read<DeviceGpsLocation>();

    loc.setGpsLocation(data);
    setMyPosicion();

    setState(() {
      currentLocation = data;
    });
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
    return BlocBuilder<GoogleMapMarkers, Set<Marker>>(
      builder: (context, markers) {
        List<Marker> myList = markers.toList();
        if (myList.isNotEmpty) {
          Marker lastElement = myList.last;
          Future.delayed(const Duration(seconds: 2), () {
            updateFocusMap(lastElement.position, markers);
            showMarkerInfoWindow(markers);
          });
        }

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
                  myPosicion,
                  ...markers,
                  ...markersNearCanchas,
                },
                zoomControlsEnabled: false,
              )
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}
