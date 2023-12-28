import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:grassport_app/models/logged_user.dart';
import 'package:grassport_app/presentation/bloc/loged_user_data/bloc.dart';
import 'package:grassport_app/presentation/router/starting_app_routes.dart';
import 'package:grassport_app/presentation/styles/colors.dart';
import 'package:grassport_app/services/auth_login.dart';
import 'package:grassport_app/services/clear_data.dart';

// ignore: must_be_immutable
class ProfileTop extends StatelessWidget {
  String nombre;

  ProfileTop({super.key, required this.nombre});

  @override
  Widget build(BuildContext context) {
    UserDisplayed? userData = context.watch<LoggedUser>().state;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 150, // Set the desired width
          child: RichText(
            maxLines: 1,
            text: TextSpan(
              text: 'Hola ',
              style: TextStyle(color: c1, fontSize: 18, fontFamily: "blinker"),
              children: <TextSpan>[
                TextSpan(
                  text: userData?.displayName, //
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class ProfileSettings extends StatelessWidget {
  const ProfileSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final userLogged = context.read<LoggedUser>();

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.17,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconSetting(
            fun: () {
              Navigator.pushNamed(context, routeEditProfile);
            },
            text: "Mi perfil",
            icon: "assets/app_icons/profile_icon.svg",
          ),
          IconSetting(
            fun: () {
              Navigator.pushNamed(context, routeReportProblem);
            },
            text: "Reportar un problema",
            icon: "assets/app_icons/warning.svg",
          ),
          IconSetting(
            fun: () async {
              if (userLogged.state != null) {
                Navigator.pushNamed(context, routeLogin);
                await logOutWithGoogle();
                // ignore: use_build_context_synchronously
                Timer(const Duration(seconds: 2), () {
                  clearDataLoggedUser(context);
                });
              }
              // ignore: use_build_context_synchronously
            },
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
              onPressed: () {
                Navigator.pushNamed(context, routeTermsConditions);
              },
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
