import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grassport_app/presentation/bloc/charge/bloc.dart';
import 'package:grassport_app/presentation/router/starting_app_routes.dart';
import 'package:grassport_app/presentation/styles/colors.dart';
import '../chargeScreens/main_charge.dart';
import '../../styles/systemThemes.dart';

class StartView extends StatefulWidget {
  const StartView({super.key});

  @override
  State<StartView> createState() => _StartViewState();
}

class _StartViewState extends State<StartView> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemModifiers.overlayLigth);
  }

  @override
  Widget build(context) {
    context.read<ChargeRoute>().changeRoute(routePreviews);
    return Container(
      color: c1,
      child: const EffectIntro(),
    );
  }
}
