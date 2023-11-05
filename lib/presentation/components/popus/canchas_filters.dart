import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:grassport_app/presentation/styles/colors.dart';

class FliterPopup extends StatelessWidget {
  const FliterPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: c1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ), //this right here
      child: SizedBox(
        height: 150.0,
        width: 340.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(10),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Icon(
                  Icons.close,
                  color: c9,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 30, right: 30),
              child: FilterOptions(),
            ),
          ],
        ),
      ),
    );
  }
}

class FilterOptions extends StatelessWidget {
  const FilterOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Filtrar por:"),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () {},
              style: const ButtonStyle(
                minimumSize: MaterialStatePropertyAll(Size(120, 40)),
              ),
              child: Text(
                "Gratis",
                style: TextStyle(
                  color: c9,
                  fontSize: 18,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: const ButtonStyle(
                minimumSize: MaterialStatePropertyAll(Size(120, 40)),
              ),
              child: Text(
                "De pago",
                style: TextStyle(
                  color: c9,
                  fontSize: 18,
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
