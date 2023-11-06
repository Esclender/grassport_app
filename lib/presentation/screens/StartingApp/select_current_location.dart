import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grassport_app/presentation/bloc/locations/blocs.dart';
import 'package:grassport_app/presentation/components/location_search_list.dart';
import 'package:grassport_app/presentation/styles/colors.dart';
import 'package:grassport_app/presentation/styles/systemThemes.dart';

class SelectCurrentLocation extends StatefulWidget {
  const SelectCurrentLocation({super.key});

  @override
  State<SelectCurrentLocation> createState() => _SelectCurrentState();
}

class _SelectCurrentState extends State<SelectCurrentLocation> {
  @override
  Widget build(BuildContext context) {
    final locationData = context.read<SelectLocation>();
    List registros = context.watch<SelectLocation>().getRegistros();

    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemModifiers.overlayLigth,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: c1,
          appBar: AppBar(
            surfaceTintColor: Colors.transparent,
            backgroundColor: c1,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SearchBar(
                  backgroundColor: MaterialStateProperty.all(c2),
                  elevation: MaterialStateProperty.all(2.0),
                  constraints:
                      const BoxConstraints(maxWidth: 330, minHeight: 50),
                  leading: const Icon(Icons.search),
                  onChanged: (_) {
                    if (_ == "") {
                      locationData.toggleState(0);
                    } else {
                      locationData.toggleState(1);
                    }
                  },
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .47,
                child: Searching(
                  historyData: locationData,
                  registros: registros,
                ),
              ),
              Expanded(
                //height: MediaQuery.of(context).size.height * .5,
                child: Searching(
                  historyData: locationData,
                  registros: const [
                    {
                      "leading": "place",
                      "department": "Los olivos",
                      "location": "Los olivos, independencia"
                    },
                    {
                      "leading": "place",
                      "department": "Los olivos",
                      "location": "Los olivos, independencia"
                    },
                  ],
                  header: 2,
                ),
              )
            ],
          ),
        ));
  }
}
