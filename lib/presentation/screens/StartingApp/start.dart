import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'previews.dart';
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
  double _scale = 1.0;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemModifiers.overlayLigth);

    Future.delayed(const Duration(milliseconds: 1990), () {
      SystemChrome.setSystemUIOverlayStyle(SystemModifiers.overlayDark);
    });

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3), // Adjust the duration as needed
    );

    _controller.forward(); // Start the animation

    // Add a curve to the animation
    final curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut, // Replace with your desired curve
    );

    curvedAnimation.addListener(() {
      setState(() {
        _scale = curvedAnimation.value * 20.0;
      });
    });
  }

  @override
  Widget build(context) {
    return Container(
      color: c1,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Transform.scale(
            scale: _scale,
            child: Image.asset(
              'assets/images/start-vector.png',
              fit: BoxFit.contain,
            ),
          ),
          const LogoAnimation()
        ],
      ),
    );
  }
}

class LogoAnimation extends StatefulWidget {
  const LogoAnimation({super.key});

  @override
  State<LogoAnimation> createState() => _StartingState();
}

class _StartingState extends State<LogoAnimation> {
  Alignment _alignment = Alignment.bottomCenter;

  void nextSwiper() {}

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 1), () {
      setState(() {
        _alignment = Alignment.center;
      });
    });

    Timer(const Duration(seconds: 2), () {
      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType
              .rightToLeft, // Define your custom transition type
          duration: const Duration(seconds: 5), // Set the transition duration
          child: const Previews(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedAlign(
          alignment: _alignment,
          duration: const Duration(seconds: 1),
          curve: Curves.fastOutSlowIn,
          child: Image.asset('assets/images/Logo.png'),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 160.0),
          child: AnimatedAlign(
            alignment: _alignment,
            duration: const Duration(seconds: 1),
            curve: Curves.fastOutSlowIn,
            child: Text(
              'GrasSport',
              style: TextStyle(
                fontFamily: 'blinker',
                fontSize: 35.0,
                color: c2,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        )
      ],
    );
  }
}
