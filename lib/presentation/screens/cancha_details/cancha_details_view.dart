import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:grassport_app/models/cancha_info.dart';
import 'package:grassport_app/presentation/components/map.dart';
import 'package:grassport_app/presentation/components/stars_rating.dart';
import 'package:grassport_app/presentation/styles/colors.dart';

// ignore: must_be_immutable
class CanchaDetails extends StatefulWidget {
  CanchaInfo cancha;

  CanchaDetails({super.key, required this.cancha});

  @override
  State<CanchaDetails> createState() => _CanchaDetailsState();
}

class _CanchaDetailsState extends State<CanchaDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.27,
                width: MediaQuery.of(context).size.width * 0.95,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  image: DecorationImage(
                      image: NetworkImage(widget.cancha.img),
                      fit: BoxFit.cover),
                ),
              ),
              const Gap(10),
              DetailsTitles(
                data: widget.cancha,
              ),
              Text(
                "Lorem ipsum dolor sit amet consectetur. Eu eget a urna id varius urna. Aliquet ornare bibendum blandit et. Congue quis malesuada quam velit sed sed. Cursus maecenas lectus ridiculus porttitor.",
                style: TextStyle(color: c11),
              ),
              const Gap(10),
              Text(
                widget.cancha.direccion,
                style: const TextStyle(fontSize: 18),
              ),
              const StreetMap(),
              const Gap(15),
              const ActionBtns()
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class DetailsTitles extends StatelessWidget {
  CanchaInfo data;
  DetailsTitles({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data.nombre,
              style: TextStyle(color: c9, fontSize: 20),
            ),
            Text(
              data.owner,
              style: TextStyle(color: c11, fontSize: 16),
            ),
            StarsRating(
              canchaUpdate: () {},
              rate: data.rating,
              isDetails: true,
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "S/ ${data.price}",
              style: TextStyle(color: c9, fontSize: 20),
            ),
            Text(
              "${data.horario["start"]} a ${data.horario["end"]}",
              style: TextStyle(color: c11, fontSize: 16),
            )
          ],
        ),
      ],
    );
  }
}

class ActionBtns extends StatelessWidget {
  const ActionBtns({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            backgroundColor: c14,
            foregroundColor: c1,
            padding: const EdgeInsets.all(0.0),
          ),
          child: const Icon(
            Icons.bookmark_outline,
            size: 35.0,
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            backgroundColor: c15,
            foregroundColor: c1,
            padding: const EdgeInsets.all(0.0),
          ),
          child: SvgPicture.asset(
            "assets/app_icons/whatsapp.svg",
            width: 30,
          ),
        )
      ],
    );
  }
}
//"assets/app_icons/whatsapp.svg"