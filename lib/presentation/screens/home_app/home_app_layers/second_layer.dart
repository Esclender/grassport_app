import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grassport_app/presentation/bloc/home_is_search/bloc.dart';
import 'package:grassport_app/presentation/components/popus/profile_home_pp.dart';
import 'package:grassport_app/presentation/styles/colors.dart';

// ignore: must_be_immutable
class SecondLayer extends StatefulWidget {
  const SecondLayer({super.key});

  @override
  State<SecondLayer> createState() => _SecondLayerState();
}

class _SecondLayerState extends State<SecondLayer> {
  @override
  Widget build(BuildContext context) {
    IsSearch showTopScreen = context.watch<IsSearch>();

    return Stack(
      children: [
        Row(
          mainAxisAlignment: showTopScreen.state
              ? MainAxisAlignment.center
              : MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: SearchBar(
                onTap: () {
                  showTopScreen.toggleSearch(true);
                },
                hintText: "Buscar por canchas",
                hintStyle: MaterialStateProperty.all(
                  const TextStyle(color: Color.fromARGB(141, 158, 158, 158)),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(c1),
                elevation: MaterialStateProperty.all(1.0),
                constraints: BoxConstraints(
                    maxWidth: showTopScreen.state ? 350 : 300, minHeight: 50),
                leading: const Icon(Icons.search),
              ),
            ),
            showTopScreen.state ? const Offstage() : const Avatar(),
          ],
        )
      ],
    );
  }
}

class Avatar extends StatelessWidget {
  const Avatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60),
      child: GestureDetector(
        onTap: () {
          showDialog(
              context: context, builder: (context) => const ProfilePopup());
        },
        child: Container(
          decoration: BoxDecoration(
            color: c8,
            borderRadius: BorderRadius.circular(50.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: CircleAvatar(
              radius: 15.0,
              backgroundColor: c1,
              child: Icon(
                Icons.person_2_outlined,
                color: c8,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
