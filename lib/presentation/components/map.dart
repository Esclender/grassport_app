import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// ignore: must_be_immutable
class StreetMap extends StatefulWidget {
  LatLng location;

  StreetMap({super.key, required this.location});

  @override
  State<StreetMap> createState() => _StreetMapState();
}

class _StreetMapState extends State<StreetMap> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  BitmapDescriptor markerCancha = BitmapDescriptor.defaultMarker;

  @override
  void initState() {
    super.initState();
  }

  void addCustomIcon() {
    BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      "assets/app_icons/cancha_icon_location.png",
    ).then(
      (icon) {
        setState(() {
          markerCancha = icon;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.90,
      height: MediaQuery.of(context).size.height * 0.50,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: widget.location,
          zoom: 14.4746,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: {
          Marker(
            markerId: const MarkerId("Posicion"),
            position:
                LatLng(widget.location.latitude, widget.location.longitude),
            icon: markerCancha,
          ),
        },
      ),
    );
  }
}
