import "package:flutter/material.dart";
import 'package:gap/gap.dart';
import '../styles/colors.dart';

//ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  Color? bg = Colors.white;
  String text = "Siguiente";
  final Function() next;
  CustomButton({super.key, required this.next, this.bg});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
          backgroundColor: bg,
          minimumSize: const Size(280, 50),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          )),
      onPressed: () {
        next();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(color: c1),
          ),
          const Gap(5),
          Image.asset('assets/images/Next.png')
        ],
      ),
    );
  }
}
