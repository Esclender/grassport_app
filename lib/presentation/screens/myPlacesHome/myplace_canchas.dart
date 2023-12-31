import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grassport_app/models/cancha_info.dart';
import 'package:grassport_app/presentation/components/stars_rating.dart';
import 'package:grassport_app/presentation/router/starting_app_routes.dart';
import 'package:grassport_app/presentation/styles/boxx_shadows.dart';
import 'package:grassport_app/presentation/styles/colors.dart';

class UserPostedCanchasWidget extends StatefulWidget {
  const UserPostedCanchasWidget({super.key});

  @override
  State<UserPostedCanchasWidget> createState() =>
      _UserPostedCanchasWidgetState();
}

class _UserPostedCanchasWidgetState extends State<UserPostedCanchasWidget> {
  CanchaInfo cancha1 = CanchaInfo(
    nombre: 'Campo Deportivo Sorana',
    address: 'Misionero Salas 654, Callao',
    description:
        'Laborum sunt magna ipsum ea proident mollit. Ipsum labore occaecat culpa qui officia quis esse qui ex duis id. Tempor aliquip tempor proident occaecat dolor.Laborum sunt magna ipsum ea proident mollit. Ipsum labore occaecat culpa qui officia quis esse qui ex duis id. Tempor aliquip tempor proident occaecat dolor.Laborum sunt magna ipsum ea proident mollit. Ipsum labore occaecat culpa qui officia quis esse qui ex duis id. Tempor aliquip tempor proident occaecat dolor. ',
    isOpen: true,
    location: LatLng(-12.0116547, -77.1024219),
  );

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Gap(50),
        StackCardWithImage(
          canchaData: cancha1,
        ),
        const Gap(50),
      ],
    );
  }
}

// ignore: must_be_immutable
class StackCardWithImage extends StatelessWidget {
  double borderValue = 25;

  CanchaInfo canchaData;

  StackCardWithImage({super.key, required this.canchaData});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(30),
      height: 350,
      width: MediaQuery.of(context).size.width * 0.7,
      decoration: BoxDecoration(
        color: c15,
        borderRadius: BorderRadius.circular(borderValue),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF00FF00).withOpacity(0.5), // Green neon color
            blurRadius: 10,
            spreadRadius: 3,
          ),
          BoxShadow(
            color: Color(0xFF00FF00).withOpacity(0.5),
            blurRadius: 20,
            spreadRadius: 5,
          ),
          BoxShadow(
            color: Color(0xFF00FF00).withOpacity(0.5),
            blurRadius: 30,
            spreadRadius: 7,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(borderValue),
                topRight: Radius.circular(borderValue),
              ),
              boxShadow: [simpleShadow],
            ),
            height: 150,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(borderValue),
                topRight: Radius.circular(borderValue),
              ),
              child: Image.network(
                'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=AWU5eFi0Qs7QRGzA3t-GZjvnpzggQKk8iPUfercxGKMG4br5mMdJ-I7kjQPs6zR49a8Iv9DpEA_BXJBC67UKRSPRtQi9R4FCLzTOsnAen8-f-QaIX3CaFAVNY95ep9FEi5P8G39WVa_jHQQOD1EzsvIgx_GeaS1w10wThHOSW37rmL2IVy4Q&key=AIzaSyDqtTbNkH59t_Ia6vzUGTH7vNAXaeL8g0Q',
                fit: BoxFit.cover,
              ),
            ),
          ),
          _cardDescription(context),
        ],
      ),
    );
  }

  Widget _cardDescription(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    canchaData.nombre,
                    style: TextStyle(
                      color: c1,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    canchaData.address,
                    style: TextStyle(
                      color: c1,
                      fontWeight: FontWeight.w200,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, routeMyPlacesCanchaDetails,
                      arguments: canchaData);
                },
                child: Column(
                  children: [
                    Icon(
                      Icons.store,
                      color: c1,
                      size: 40,
                    ),
                    Text(
                      'Ver info',
                      style: TextStyle(
                        color: c1,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          StarsRating(
            canchaUpdate: () {},
            rate: 5,
            isDetails: false,
          ),
          Text(
            canchaData.description,
            style: TextStyle(
              color: c1,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          )
        ],
      ),
    );
  }
}
