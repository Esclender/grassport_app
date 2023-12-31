import "package:flutter/material.dart";

//ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  Color? bg = Colors.white;
  Widget text;
  final Function() next;
  CustomButton({super.key, required this.next, required this.text, this.bg});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: bg,
        minimumSize: const Size(280, 50),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
      ),
      onPressed: () {
        next();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [text],
      ),
    );
  }
}
