import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:grassport_app/presentation/styles/colors.dart';

// ignore: must_be_immutable
class ProfileTop extends StatelessWidget {
  String nombre;

  ProfileTop({super.key, required this.nombre});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
            text: 'Hola ',
            style: TextStyle(color: c1, fontSize: 18, fontFamily: "blinker"),
            children: <TextSpan>[
              TextSpan(
                text: nombre,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        CircleAvatar(
          backgroundColor: c1,
        )
      ],
    );
  }
}

class ProfileSettings extends StatelessWidget {
  const ProfileSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.17,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconSetting(
            fun: () {},
            text: "Mi perfil",
            icon: "assets/app_icons/profile_icon.svg",
          ),
          IconSetting(
            fun: () {},
            text: "Filtros",
            icon: "assets/app_icons/filter_icon.svg",
          ),
          IconSetting(
            fun: () {},
            text: "Reportar un problema",
            icon: "assets/app_icons/warning.svg",
          ),
          IconSetting(
            fun: () {},
            text: "Cerrar sesion",
            icon: "assets/app_icons/cerrar_sesion.svg",
          )
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class IconSetting extends StatelessWidget {
  String text;
  String icon;
  Function() fun;

  IconSetting(
      {super.key, required this.text, required this.icon, required this.fun});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: fun,
      child: Row(
        children: [
          SvgPicture.asset(
            icon,
            width: 20,
            height: 16,
          ),
          const Gap(5),
          Text(
            text,
            style: TextStyle(color: c1),
          ),
        ],
      ),
    );
  }
}

class ProfilePopup extends StatelessWidget {
  const ProfilePopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: c8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ), //this right here
      child: SizedBox(
        height: 300.0,
        width: 340.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Gap(10),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.close,
                color: c1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: ProfileTop(
                nombre: "Esclender Lugo",
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15, right: 20.0),
              child: ProfileSettings(),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                "Terminos y condiciones",
                style: TextStyle(
                  color: c1,
                  decoration: TextDecoration.underline,
                  decorationColor: c1,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
