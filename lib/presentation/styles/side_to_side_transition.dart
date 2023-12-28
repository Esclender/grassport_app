import 'package:flutter/material.dart';

class SideToSideTransition extends PageRouteBuilder {
  SideToSideTransition({required this.child})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 1500),
        );
  final Widget child;
}

class FadeInTransition extends PageRouteBuilder {
  FadeInTransition({required this.child})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) {
            const begin = 0.0;
            const end = 1.0;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return FadeTransition(
              opacity: animation.drive(tween),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 1000),
        );
  final Widget child;
}

class TopToBottom extends PageRouteBuilder {
  TopToBottom({required this.child})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 1500),
        );
  final Widget child;
}
