import 'package:flutter/material.dart';

class StreetMap extends StatefulWidget {
  const StreetMap({super.key});

  @override
  State<StreetMap> createState() => _StreetMapState();
}

class _StreetMapState extends State<StreetMap> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Image.asset(
        'assets/images/Map_small.png',
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
    );
  }
}
