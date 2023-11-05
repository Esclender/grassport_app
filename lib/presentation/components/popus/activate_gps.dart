import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:grassport_app/presentation/components/buttons.dart';
import 'package:grassport_app/presentation/styles/colors.dart';

class ActivateGps extends StatelessWidget {
  const ActivateGps({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: c1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ), //this right here
      child: SizedBox(
        height: 220.0,
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
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  CustomButton(
                    next: () {},
                    text: Text(
                      "Permitir acceso a GPS",
                      style: TextStyle(color: c1),
                    ),
                    bg: c8,
                  ),
                  const Gap(10),
                  CustomButton(
                    next: () {
                      Navigator.pop(context);
                    },
                    text: Text(
                      "Cancelar",
                      style: TextStyle(color: c9),
                    ),
                    bg: c1,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
