import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
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

    Timer(const Duration(seconds: 2), () {
      context.go('/previews');
    });
  }

  @override
  Widget build(context) {
    return Container(
      color: c1,
      child: const EffectIntro(),
    );
  }
}
