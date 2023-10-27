import 'package:flutter/material.dart';
import 'package:grassport_app/presentation/components/stars_rating.dart';
import 'package:grassport_app/presentation/router/starting_app_routes.dart';
import 'package:grassport_app/presentation/styles/boxx_shadows.dart';
import 'package:grassport_app/presentation/styles/colors.dart';

// ignore: must_be_immutable
class CanchaCard extends StatelessWidget {
  Map data;

  CanchaCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //Navigator.pushNamed(context, '/cancha', arguments: {'id': data['id']});
        Navigator.pushNamed(context, routeCanchaDetails);
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
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                child: Image.network(
                  data["img"],
                  height: MediaQuery.of(context).size.height * .25,
                ),
              ),
            ),
            CardInfo(
              data: data,
            )
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CardInfo extends StatelessWidget {
  Map data;

  CardInfo({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.only(left: 30, bottom: 10, right: 20),
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data["nombre"],
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  data["owner"],
                  style: TextStyle(color: c11),
                ),
                StarsRating(
                  canchaUpdate: () {},
                  rate: data["rating"],
                  isDetails: false,
                ),
                Text(
                  data["direccion"],
                  style: TextStyle(color: c9),
                )
              ],
            ),
            SizedBox(
              width: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data["price"] > 0 && data["price"] != null
                        ? "S/${data["price"]}"
                        : "Gratis",
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    "${data["horario"]["start"]} a ${data["horario"]["end"]}",
                    style: TextStyle(color: c11),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
