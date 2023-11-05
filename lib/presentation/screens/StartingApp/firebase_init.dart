import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:grassport_app/presentation/screens/StartingApp/location_agree.dart';
import 'package:grassport_app/presentation/screens/chargeScreens/main_charge.dart';

class FirebaseInit extends StatelessWidget {
  const FirebaseInit({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return const AgreementLocation();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return const Scaffold(
            body: Text("Error"),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return const EffectIntro();
      },
    );
  }
}
