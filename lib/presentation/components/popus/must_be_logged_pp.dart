import 'package:flutter/material.dart';
import 'package:grassport_app/presentation/styles/colors.dart';

// ignore: must_be_immutable
class MustBeLoggedPopup extends StatelessWidget {
  const MustBeLoggedPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: c4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(55.0),
      ), //this right here
      content: Padding(
        padding: const EdgeInsets.all(12.0),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              WidgetSpan(
                child: Icon(
                  Icons.warning_amber_rounded,
                  size: 20,
                  color: c1,
                ),
              ),
              TextSpan(
                text: " Inicia sesion para guardar",
                style: TextStyle(fontSize: 20, color: c1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
