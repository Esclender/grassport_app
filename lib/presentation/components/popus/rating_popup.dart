import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:grassport_app/presentation/styles/colors.dart';

// ignore: must_be_immutable
class RatingPopup extends StatelessWidget {
  int rate;
  RatingPopup({super.key, required this.rate});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: c16,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ), //this right here
      child: SizedBox(
        height: 200.0,
        width: 340.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Gap(10),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Icon(
                  Icons.close,
                  color: c1,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "Calificar esta cancha:",
                style: TextStyle(color: c1, fontSize: 16),
              ),
            ),
            RatingStars(
              rate: rate,
            )
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class RatingStars extends StatefulWidget {
  int rate;

  RatingStars({super.key, this.rate = 0});

  @override
  State<RatingStars> createState() => _RatingStarsState();
}

class _RatingStarsState extends State<RatingStars> {
  void changeRate(value) {
    setState(() {
      widget.rate = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20),
      width: 290,
      height: 60,
      child: Row(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, ind) {
                return GestureDetector(
                  onTap: () {
                    //this is gonna be ind + 1
                    //print("Star $ind");
                  },
                  child: Icon(
                    widget.rate >= (ind + 1) ? Icons.star : Icons.star_border,
                    color: c13,
                    size: 50,
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
