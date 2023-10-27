import 'package:flutter/material.dart';
import 'package:grassport_app/presentation/styles/colors.dart';

// ignore: must_be_immutable
class StarsRating extends StatefulWidget {
  final Function() canchaUpdate;
  int rate;
  bool isDetails;

  StarsRating(
      {super.key,
      required this.canchaUpdate,
      required this.rate,
      required this.isDetails});

  @override
  State<StarsRating> createState() => _StarsRatingState();
}

class _StarsRatingState extends State<StarsRating> {
  @override
  Widget build(BuildContext context) {
    int countStars = widget.rate ?? 1;

    return SizedBox(
      width: 130,
      height: 30,
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                print("click rating");
              },
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, ind) {
                  return Icon(
                    countStars >= (ind + 1) ? Icons.star : Icons.star_border,
                    color: c13,
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
