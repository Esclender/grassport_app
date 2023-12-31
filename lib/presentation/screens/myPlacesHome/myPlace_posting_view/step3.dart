import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grassport_app/models/cancha_info.dart';
import 'package:grassport_app/presentation/components/map.dart';
import 'package:grassport_app/presentation/styles/colors.dart';

// ignore: must_be_immutable
class PreviewStep3 extends StatefulWidget {
  CanchaInfo data;

  PreviewStep3({
    super.key,
    required this.data,
  });

  @override
  State<PreviewStep3> createState() => _PreviewStep3State();
}

class _PreviewStep3State extends State<PreviewStep3> {
  late TextEditingController nameController;
  late TextEditingController addressController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();

    setForms();
  }

  void setForms() {
    setState(() {
      nameController = TextEditingController(text: widget.data.nombre);
      addressController = TextEditingController(text: widget.data.address);
      descriptionController =
          TextEditingController(text: widget.data.description);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: double.infinity,
            height: 200,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              image: DecorationImage(
                image: NetworkImage(
                    'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=AWU5eFi0Qs7QRGzA3t-GZjvnpzggQKk8iPUfercxGKMG4br5mMdJ-I7kjQPs6zR49a8Iv9DpEA_BXJBC67UKRSPRtQi9R4FCLzTOsnAen8-f-QaIX3CaFAVNY95ep9FEi5P8G39WVa_jHQQOD1EzsvIgx_GeaS1w10wThHOSW37rmL2IVy4Q&key=AIzaSyDqtTbNkH59t_Ia6vzUGTH7vNAXaeL8g0Q'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Gap(10),
          TextFormField(
            enabled: false,
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'Nombre de la cancha',
              labelStyle: TextStyle(color: c1),
              fillColor: c8,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
            style: TextStyle(color: c1),
          ),
          const Gap(10),
          TextFormField(
            enabled: false,
            controller: addressController,
            decoration: InputDecoration(
              labelText: 'Direccion',
              labelStyle: TextStyle(color: c1),
              fillColor: c8,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
            style: TextStyle(color: c1),
          ),
          const Gap(10),
          TextFormField(
            enabled: false,
            controller: descriptionController,
            maxLines: 3,
            decoration: InputDecoration(
              labelText: 'Descripcion',
              labelStyle: TextStyle(color: c1),
              fillColor: c8,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
            style: TextStyle(color: c1),
          ),
          const Gap(10),
          StreetMap(
            location: LatLng(-12.0116547, -77.1024219),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Anterior',
                  style: TextStyle(color: c15, fontWeight: FontWeight.bold),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Publicar',
                  style: TextStyle(color: c15, fontWeight: FontWeight.bold),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
