import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grassport_app/presentation/bloc/charge/bloc.dart';
import '../../styles/systemThemes.dart';
import '../../styles/colors.dart';

class EffectIntro extends StatefulWidget {
  const EffectIntro({Key? key}) : super(key: key);

  @override
  State<EffectIntro> createState() => _EffectIntroState();
}

class _EffectIntroState extends State<EffectIntro>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;
  AlignmentGeometry alignment = Alignment.bottomCenter;
  List<Timer> timers = [];

  @override
  dispose() {
    _controller.dispose();
    for (var timer in timers) {
      timer.cancel();
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    timers.add(Timer(const Duration(milliseconds: 1600), () {
      SystemChrome.setSystemUIOverlayStyle(SystemModifiers.overlayDark);
    }));

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _scale = Tween<double>(begin: 1.0, end: 20.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward();

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
        color: c1,
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

  const LogoAnimation({Key? key, required this.alignment, required this.route})
      : super(key: key);

  @override
  State<LogoAnimation> createState() => _StartingState();
}

class _StartingState extends State<LogoAnimation>
    with SingleTickerProviderStateMixin {
  List<Timer> timers = [];

  @override
  void initState() {
    super.initState();

    timers.add(Timer(const Duration(seconds: 2), () {
      Navigator.pushNamed(context, widget.route);
    }));
  }

  @override
  void dispose() {
    for (var timer in timers) {
      timer.cancel();
    }
    super.dispose();
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
