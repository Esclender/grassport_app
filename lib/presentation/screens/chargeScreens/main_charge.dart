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

  @override
  void initState() {
    super.initState();

    Timer(const Duration(milliseconds: 1500), () {
      SystemChrome.setSystemUIOverlayStyle(SystemModifiers.overlayDark);
    });

    _controller = AnimationController(
      vsync: this,
      duration:
          const Duration(milliseconds: 2500), // Adjust the duration as needed
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
      setState(() {});
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

class _StartingState extends State<LogoAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controllador;
  late Animation<Alignment> _alignment;

  //MANAGE THE ANIMATIONS WITH LISTENERS LIKE ABOVE XD

  @override
  void initState() {
    super.initState();

    _controllador = AnimationController(
      vsync: this,
      duration:
          const Duration(milliseconds: 100), // Adjust the duration as needed
    );

    // Create the alignment animation
    _alignment = AlignmentTween(
      begin: Alignment.bottomCenter,
      end: Alignment.center,
    ).animate(
      CurvedAnimation(
        parent: _controllador,
        curve: Curves.fastOutSlowIn,
      ),
    );

    _controllador.forward();

    _alignment.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedAlign(
          alignment: _alignment.value,
          duration: const Duration(seconds: 1),
          curve: Curves.fastOutSlowIn,
          child: Image.asset('assets/images/Logo.png'),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 160.0),
          child: AnimatedAlign(
            alignment: _alignment.value,
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
