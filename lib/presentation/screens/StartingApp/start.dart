import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grassport_app/presentation/styles/colors.dart';
import 'package:page_transition/page_transition.dart';
import 'previews.dart';
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

    Future.delayed(const Duration(milliseconds: 2500), () {
      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.rightToLeftWithFade,
          duration:
              const Duration(milliseconds: 4700), // Set the transition duration
          child: const Previews(),
        ),
      );
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



    // Future.delayed(const Duration(microseconds: 1500), () {
    //   Navigator.push(
    //     context,
    //     PageTransition(
    //       type: PageTransitionType.rightToLeftWithFade,
    //       duration:
    //           const Duration(milliseconds: 4700), // Set the transition duration
    //       child: const Previews(),
    //     ),
    //   );
    // });