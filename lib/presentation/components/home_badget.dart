import 'package:flutter/material.dart';
import 'package:grassport_app/presentation/styles/colors.dart';

class HomeBadget extends StatefulWidget {
  const HomeBadget({super.key});

  @override
  State<HomeBadget> createState() => _HomeBadgetState();
}

class _HomeBadgetState extends State<HomeBadget> {
  int selectedIcon = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      height: 40,
      decoration: BoxDecoration(
          color: c8,
          borderRadius: BorderRadius.circular(40.0),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(127, 0, 0, 0),
              offset: Offset(0, 0.7),
              blurRadius: 2,
            ),
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                selectedIcon = 0;
              });
            },
            icon: selectedIcon == 0
                ? const Icon(
                    Icons.home_rounded,
                    color: Colors.white,
                  )
                : const Icon(
                    Icons.home_outlined,
                    color: Colors.white,
                  ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                selectedIcon = 1;
              });
            },
            icon: selectedIcon == 1
                ? const Icon(
                    Icons.bookmark,
                    color: Colors.white,
                  )
                : const Icon(
                    Icons.bookmark_border,
                    color: Colors.white,
                  ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                selectedIcon = 2;
              });
            },
            icon: selectedIcon == 2
                ? const Icon(
                    Icons.notifications,
                    color: Colors.white,
                  )
                : const Icon(
                    Icons.notifications_none_outlined,
                    color: Colors.white,
                  ),
          ),
        ],
      ),
    );
  }
}
