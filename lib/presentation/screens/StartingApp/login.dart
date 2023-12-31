import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grassport_app/presentation/router/starting_app_routes.dart';
import 'package:grassport_app/presentation/styles/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import '../../styles/systemThemes.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Size btnSize = const Size(300, 70);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemModifiers.overlayDark,
      child: Container(
        color: c8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Grassport',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w300,
                fontFamily: 'blinker',
                color: c1,
                decoration: TextDecoration.none,
              ),
            ),
            const Gap(10),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                  maximumSize: btnSize,
                  side: BorderSide(
                    width: 3.0,
                    color: c1,
                  ),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/images/icons8-logo-de-google.svg",
                    height: 30,
                  ),
                  const Gap(2),
                  Text(
                    'Iniciar sesion con Google',
                    style: TextStyle(color: c1),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, routeAgreementLocation);
              },
              child: Text(
                'Iniciar sesion despues',
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
