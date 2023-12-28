import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grassport_app/presentation/bloc/charge/bloc.dart';
import '../../styles/systemThemes.dart';
import '../../styles/colors.dart';

class EffectIntro extends StatefulWidget {
  const EffectIntro({super.key});

  @override
  State<EffectIntro> createState() => _EffectIntroState();
}

class _EffectIntroState extends State<EffectIntro>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;
  AlignmentGeometry alignment = Alignment.bottomCenter;

  @override
  dispose() {
    _controller.dispose(); // you need this
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    Timer(const Duration(milliseconds: 1600), () {
      SystemChrome.setSystemUIOverlayStyle(SystemModifiers.overlayDark);
    });

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3), // Adjust the duration as needed
    );

    // Create the scale animation
    _scale = Tween<double>(begin: 1.0, end: 20.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut, // Replace with your desired curve
      ),
    );

    // Start the animation
    _controller.forward();

    // Add a listener to the scale animation
    _scale.addListener(() {
      setState(() {
        alignment = Alignment.center;
      });
    });
  }

  @override
  Widget build(context) {
    String currentRoute = context.read<ChargeRoute>().state;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemModifiers.overlayDark,
      child: Container(
        color: Colors.transparent,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Transform.scale(
              scale: _scale.value,
              child: Image.asset(
                'assets/images/start-vector.png',
                fit: BoxFit.contain,
              ),
            ),
            LogoAnimation(
              alignment: alignment,
              route: currentRoute,
            )
          ],
        ),
      ),
    );
  }
}

class LogoAnimation extends StatefulWidget {
  final AlignmentGeometry alignment;
  final String route;

  const LogoAnimation(
      {super.key, required this.alignment, required this.route});

  @override
  State<LogoAnimation> createState() => _StartingState();
}

class _StartingState extends State<LogoAnimation>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer(const Duration(seconds: 2), () {
        Navigator.pushNamed(context, widget.route);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedAlign(
          alignment: widget.alignment,
          duration: const Duration(seconds: 1),
          curve: Curves.fastOutSlowIn,
          child: Image.asset('assets/images/Logo.png'),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 160.0),
          child: AnimatedAlign(
            alignment: widget.alignment,
            duration: const Duration(seconds: 1),
            curve: Curves.fastOutSlowIn,
            child: Text(
              'GrasSport',
              style: TextStyle(
                fontSize: 35.0,
                color: c2,
                decoration: TextDecoration.none,
                fontFamily: 'blinker',
              ),
            ),
          ),
        )
      ],
    );
  }
}
