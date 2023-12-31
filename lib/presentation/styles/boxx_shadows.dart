import 'package:flutter/material.dart';
import 'package:grassport_app/presentation/styles/colors.dart';

BoxShadow canchaCards = const BoxShadow(
  color: Colors.grey,
  offset: Offset(0, 0.7),
  blurRadius: 1,
);

BoxShadow simpleShadow = const BoxShadow(
  color: Color.fromARGB(127, 0, 0, 0),
  offset: Offset(0, 0.7),
  blurRadius: 2,
);

BoxShadow neoShadow = const BoxShadow(
  color: Colors.greenAccent,
  blurRadius: 10.0,
  spreadRadius: 2.0,
  offset: Offset(0.0, 0.0),
);

BoxShadow neoDarkShadow = BoxShadow(
  color: c15.withOpacity(0.05),
  offset: Offset(0, 0.7),
  blurRadius: 2,
);
