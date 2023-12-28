import 'package:flutter/material.dart';

class CircleShape extends StatelessWidget {
  final Color color;

  final double height;

  final double width;

  const CircleShape({
    super.key,
    required this.color,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: color,
      ),
    );
  }
}
