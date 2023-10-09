import 'package:flutter/material.dart';

class FadePageTransition extends PageRouteBuilder {
  FadePageTransition({required this.child})
      : super(pageBuilder: (context, animation, secondaryAnimation) {
          const begin = 0.0;
          const end = 1.0;
          const curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return FadeTransition(
            opacity: animation.drive(tween),
            child: child,
          );
        });
  final Widget child;
}
