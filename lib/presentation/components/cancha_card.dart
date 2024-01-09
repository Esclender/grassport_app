import 'package:flutter/material.dart';
import 'package:grassport_app/api/api_client.dart';
import 'package:grassport_app/models/cancha_info.dart';
import 'package:grassport_app/presentation/components/stars_rating.dart';
import 'package:grassport_app/presentation/router/starting_app_routes.dart';
import 'package:grassport_app/presentation/styles/boxx_shadows.dart';
import 'package:grassport_app/presentation/styles/colors.dart';

// ignore: must_be_immutable
class CanchaCard extends StatelessWidget {
  CanchaMarker data;
  ApiClient myClient = ApiClient();

  CanchaCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        CanchaInfo canchaDetails =
            await myClient.getNearLocationsDetails(data.placeId);

        // ignore: use_build_context_synchronously
        Navigator.pushNamed(
          context,
          routeCanchaDetails,
          arguments: canchaDetails,
        );
      },
      child: Container(
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          color: Colors.white,
          boxShadow: [
            canchaCards,
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width * 0.85,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  image: DecorationImage(
                    image: NetworkImage(data.photoURL as String),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            CardInfo(
              data: data,
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CardInfo extends StatelessWidget {
  CanchaMarker data;

  CardInfo({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.only(left: 20, bottom: 10, right: 20),
        width: MediaQuery.of(context).size.width,
        child: Wrap(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.nombre,
                  style: const TextStyle(fontSize: 16),
                ),
                StarsRating(
                  canchaUpdate: () {},
                  rate: data.rating as int,
                  isDetails: false,
                ),
                Text(
                  data.address,
                  style: TextStyle(color: c9),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
