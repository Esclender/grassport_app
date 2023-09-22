import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grassport_app/presentation/screens/StartingApp/location_agree.dart';
import '../screens/StartingApp/previews.dart';
import '../screens/StartingApp/start.dart';

//StartView()

final router = GoRouter(
  routes: [
    GoRoute(
        path: '/',
        builder: (context, state) => const AgreementLocation(),
        routes: [
          GoRoute(
            path: 'previews',
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                transitionDuration: const Duration(seconds: 4),
                child: const Previews(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  late final Animation<Offset> offsetAnimation = Tween<Offset>(
                    begin: const Offset(1.5, 0.0),
                    end: const Offset(0.0, 0.0),
                  ).animate(animation);

                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                },
              );
            },
          ),
        ]),
  ],
);
