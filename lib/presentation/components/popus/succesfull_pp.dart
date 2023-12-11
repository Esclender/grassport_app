import 'package:flutter/material.dart';
import 'package:grassport_app/presentation/styles/colors.dart';

// ignore: must_be_immutable
class SuccesfullPopup extends StatelessWidget {
  String message;

  Color? bg;

  SuccesfullPopup({super.key, this.message = 'Guardado', this.bg});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: bg ?? c14,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(55.0),
      ), //this right here
      content: Padding(
        padding: const EdgeInsets.all(12.0),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: message,
                style: TextStyle(fontSize: 20, color: c1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
