import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    return Container(
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
          LogoAnimation(alignment: alignment)
        ],
      ),
    );
  }
}

class LogoAnimation extends StatefulWidget {
  final AlignmentGeometry alignment;
  const LogoAnimation({super.key, required this.alignment});

  @override
  State<LogoAnimation> createState() => _StartingState();
}

class _StartingState extends State<LogoAnimation>
    with SingleTickerProviderStateMixin {
  //MANAGE THE ANIMATIONS WITH LISTENERS LIKE ABOVE XD

  @override
  void initState() {
    super.initState();
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
              ),
            ),
          ),
        )
      ],
    );
  }
}
