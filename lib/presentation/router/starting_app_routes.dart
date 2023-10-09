import 'package:flutter/material.dart';
import 'package:grassport_app/presentation/screens/StartingApp/location_agree.dart';
import 'package:grassport_app/presentation/screens/StartingApp/login.dart';
import 'package:grassport_app/presentation/screens/StartingApp/previews.dart';
import 'package:grassport_app/presentation/screens/StartingApp/select_current_location.dart';
import 'package:grassport_app/presentation/screens/StartingApp/start.dart';
import 'package:grassport_app/presentation/screens/chargeScreens/main_charge.dart';
import 'package:grassport_app/presentation/styles/side_to_side_transition.dart';

const String routeStartApp = '/start';
const String routeCharge = '/charge';
const String routePreviews = '/start/previews';
const String routeLogin = '/start/login';
const String routeAgreementLocation = '/agreementLocation';
const String routeSelectLocation = '/agreementLocation/selectCurrentLocation';

class MyRouters {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/start":
        return SideToSideTransition(child: const StartView());
      case "/charge":
        return SideToSideTransition(child: const EffectIntro());
      case "/start/previews":
        return SideToSideTransition(child: const Previews());
      case "/start/login":
        return SideToSideTransition(child: const Login());
      case "/agreementLocation":
        return SideToSideTransition(child: const AgreementLocation());
      case "/agreementLocation/selectCurrentLocation":
        return SideToSideTransition(child: const SelectCurrentLocation());
      default:
        return MaterialPageRoute(builder: (context) => const StartView());
    }
  }
}
