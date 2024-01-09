import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grassport_app/presentation/bloc/device_current_location/blocs.dart';
import 'package:grassport_app/presentation/bloc/google_map_markers/bloc.dart';
import 'package:grassport_app/presentation/bloc/nearCanchas/blocs.dart';
import 'package:grassport_app/presentation/styles/colors.dart';
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

  @override
  void initState() {
    if (widget.isGps) {
      checkPermissions();
      //_liveLocation();
    } else {
      _definedLocation();
      setMarkers();
    }

    super.initState();
  }

  void updateFocusMap(latLng, markers) async {
    if (markers.isNotEmpty) {
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newLatLng(latLng));
    }
  }

  void setMyPosicion({LatLng? posLocation}) async {
    await context.read<GoogleMapMarkers>().setUserMarker(
          posLocation as LatLng,
        );
  }

  void setMarkers() async {
    // ignore: use_build_context_synchronously
    await context.read<GoogleMapMarkers>().setMarkers(context, currentLocation);

    //SET MODAL CARDS CANCHAS
    // ignore: use_build_context_synchronously
    await context
        .read<NearCanchas>()
        .getNearCanchas(currentLocation: currentLocation);

    setMyPosicion(posLocation: currentLocation);
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
    Position location = await checkIsGpsEnabled(context: c);

    //TODO: MANAGE WHEN USE DOESN'T AGREE

    LatLng data = LatLng(location.latitude, location.longitude);
    // ignore: use_build_context_synchronously
    c.read<DeviceGpsLocation>().setGpsLocation(data);

    setMyPosicion(posLocation: data);

    setState(() {
      currentLocation = data;
    });
  }

  //LISTEN
  // void _liveLocation() {
  //   LocationSettings locationSettings = AndroidSettings(
  //     accuracy: LocationAccuracy.high,
  //     distanceFilter: 0,
  //     intervalDuration: const Duration(seconds: 100),
  //   );

  //   Geolocator.getPositionStream(locationSettings: locationSettings)
  //       .listen((Position position) {
  //     LatLng actualLoc = LatLng(position.latitude, position.longitude);

  //     BuildContext c = context;
  //     c.read<DeviceGpsLocation>().setGpsLocation(actualLoc);

  //     setState(() {
  //       currentLocation = actualLoc;
  //     });
  //   });
  // }

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
        // List<Marker> myList = markers.toList();

        // if (myList.isNotEmpty) {
        //   Marker lastElemen = myList.last;

        //   Future.delayed(const Duration(seconds: 2), () {
        //     updateFocusMap(lastElemen.position, markers);
        //     showMarkerInfoWindow(markers);
        //   });
        // }

        if (currentLocation == null) {
          return Center(
            child: CircularProgressIndicator(
              color: c8,
            ),
          );
        }

        return GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: currentLocation as LatLng,
            zoom: 14.4746,
          ),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          markers: {
            ...markers,
          },
          zoomControlsEnabled: false,
          compassEnabled: false,
        );
      },
    );
  }
}
