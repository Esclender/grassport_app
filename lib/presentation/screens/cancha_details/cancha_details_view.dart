import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:grassport_app/presentation/components/map.dart';
import 'package:grassport_app/presentation/components/stars_rating.dart';
import 'package:grassport_app/presentation/styles/colors.dart';

class CanchaDetails extends StatefulWidget {
  const CanchaDetails({super.key});

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
        child: Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.network(
                    "https://ichef.bbci.co.uk/news/640/cpsprodpb/238D/production/_95410190_gettyimages-488144002.jpg",
                    fit: BoxFit.contain,
                  ),
                ),
                const Gap(10),
                const DetailsTitles(),
                Text(
                  "Lorem ipsum dolor sit amet consectetur. Eu eget a urna id varius urna. Aliquet ornare bibendum blandit et. Congue quis malesuada quam velit sed sed. Cursus maecenas lectus ridiculus porttitor.",
                  style: TextStyle(color: c11),
                ),
                const Gap(10),
                const Text(
                  "Av. México, Miraflores, Perú",
                  style: TextStyle(fontSize: 18),
                ),
                const StreetMap(),
                const Gap(15),
                const ActionBtns()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DetailsTitles extends StatelessWidget {
  const DetailsTitles({super.key});

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
              "Cancha #001",
              style: TextStyle(color: c9, fontSize: 20),
            ),
            Text(
              "Esclender Lugo",
              style: TextStyle(color: c11, fontSize: 16),
            ),
            StarsRating(
              canchaUpdate: () {},
              rate: 4,
              isDetails: true,
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "S/ 100",
              style: TextStyle(color: c9, fontSize: 20),
            ),
            Text(
              "10:00 a 11:00",
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