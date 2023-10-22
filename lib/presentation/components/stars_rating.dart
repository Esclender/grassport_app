import 'package:flutter/material.dart';
import 'package:grassport_app/presentation/styles/colors.dart';

class StarsRating extends StatefulWidget {
  final Function() canchaUpdate;
  int rate;
  StarsRating({super.key, required this.canchaUpdate, required this.rate});

  @override
  State<StarsRating> createState() => _StarsRatingState();
}

class _StarsRatingState extends State<StarsRating> {
  //0 is equal to 1 in this case, this is just to don't sum int setState

  @override
  Widget build(BuildContext context) {
    int countStars = widget.rate ?? 1;

    return SizedBox(
      width: 130,
      height: 30,
      child: Row(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, ind) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      countStars = ind;
                    });
                  },
                  child: Icon(
                    countStars >= (ind + 1) ? Icons.star : Icons.star_border,
                    color: c13,
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
