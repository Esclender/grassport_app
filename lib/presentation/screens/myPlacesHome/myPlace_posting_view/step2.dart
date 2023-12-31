import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grassport_app/presentation/bloc/device_current_location/blocs.dart';
import 'package:grassport_app/presentation/styles/colors.dart';
import 'package:grassport_app/services/location_ask.dart';

class LocationPicker extends StatefulWidget {
  final Function onConfirm;
  final Function onPrevious;

  const LocationPicker({
    super.key,
    required this.onConfirm,
    required this.onPrevious,
  });

  @override
  _LocationPickerState createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  GoogleMapController? mapController;
  LatLng? selectedLocation;

  LatLng? currentLocation;
  Set<Marker> markersNearCanchas = {};
  Marker myPosicion = const Marker(markerId: MarkerId('Posicion'));

  @override
  void initState() {
    checkPermissions();

    super.initState();
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

  @override
  void dispose() {
    super.dispose();
    mapController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (currentLocation == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Scaffold(
        body: Stack(
          children: [
            GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: currentLocation as LatLng,
                zoom: 14.4746,
              ),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              onTap: (LatLng location) {
                setState(() {
                  selectedLocation = location;
                  currentLocation = location;
                });

                setMyPosicion();
              },
              markers: {
                myPosicion,
              },
              zoomControlsEnabled: false,
              compassEnabled: false,
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.05,
              left: 0,
              right: 0,
              child: _buildSearchBar(),
            ),
          ],
        ),
        floatingActionButton: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
            color: c8,
          ),
          padding: EdgeInsets.all(5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Direccion Seleccionada: ',
                style: TextStyle(
                  color: c1,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'AV MONTECARLO MZ Z',
                style: TextStyle(
                  color: c1,
                  fontWeight: FontWeight.w200,
                ),
              ),
              const Gap(10),
              Row(
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: c1,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    ),
                    onPressed: () {
                      widget.onPrevious();
                    },
                    child: Text(
                      'Anterior',
                      style: TextStyle(color: c8),
                    ),
                  ),
                  const Gap(10),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: c1,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    ),
                    onPressed: () {
                      widget.onConfirm();
                    },
                    child: Text(
                      'Confirmar Ubicacion',
                      style: TextStyle(color: c8),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        color: c1,
        child: TypeAheadField(
          suggestionsCallback: (pattern) async {
            // Implement your location suggestions logic here
            // Example: Fetch suggestions from an API or a list
            return [''];
          },
          builder: (context, controller, focusNode) => TextField(
            controller: controller,
            focusNode: focusNode,
            autofocus: false,
            style: DefaultTextStyle.of(context)
                .style
                .copyWith(backgroundColor: c1),
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: 'Buscar direccion',
            ),
          ),
          decorationBuilder: (context, child) => Material(
            type: MaterialType.card,
            elevation: 4,
            child: child,
          ),
          itemBuilder: (context, suggestion) {
            return ListTile(
              title: Text(suggestion),
            );
          },
          onSelected: (String value) {},
        ),
      ),
    );
  }

  void _moveCameraToLocation(LatLng location) {
    mapController?.animateCamera(
      CameraUpdate.newLatLng(location),
    );
  }
}
