import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:grassport_app/presentation/components/buttons.dart';
import 'package:grassport_app/presentation/styles/colors.dart';
import 'package:grassport_app/presentation/styles/systemThemes.dart';

class AgreementLocation extends StatefulWidget {
  const AgreementLocation({super.key});

  @override
  State<AgreementLocation> createState() => _AgreementLocationState();
}

class _AgreementLocationState extends State<AgreementLocation> {
  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(SystemModifiers.overlayLigth);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: c1,
        appBar: AppBar(
          title: const Icon(Icons.arrow_back),
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.location_on,
                size: 140.0,
                color: c8,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Column(
                  children: [
                    Text(
                      'Permisos de ubicacion',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: c9),
                    ),
                    Text(
                      'Esto nos mostrara las canchas de grass cercanos',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: c10),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 100.0),
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  children: [
                    CustomButton(
                      next: () {},
                      bg: c8,
                      text: Text(
                        'Usar ubicacion actual',
                        style: TextStyle(color: c1),
                      ),
                    ),
                    const Gap(10),
                    CustomButton(
                      next: () {},
                      bg: c12,
                      text: Text(
                        'Ingresar Manualmente',
                        style: TextStyle(color: c9),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

// class LocationBtns extends StatelessWidget {
//   const LocationBtns({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return TextButton(
//         onPressed: () {}, child: const Text('Permitir ubicacion'), style: ,);
//   }
// }
