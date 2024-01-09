import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:grassport_app/presentation/styles/colors.dart';

class CustomDialogs {
  static void showSearchingDialog(context, String text) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: c1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ), //this right here
          child: SizedBox(
            height: 150.0,
            width: 340.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(
                  color: c8,
                ),
                const Gap(20),
                Flexible(
                  child: Text(
                    text,
                    style: TextStyle(
                      color: c8,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void showAlert({context, String message = '', String title = ''}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              const Icon(Icons.warning, color: Colors.green),
              const SizedBox(width: 8.0),
              Text(title, style: const TextStyle(color: Colors.green)),
            ],
          ),
          content: Text(message, style: const TextStyle(color: Colors.green)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK', style: TextStyle(color: Colors.green)),
            ),
          ],
        );
      },
    );
  }
}
