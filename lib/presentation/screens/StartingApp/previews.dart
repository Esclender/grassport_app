import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:grassport_app/models/logged_user.dart';
import 'package:grassport_app/presentation/bloc/isAdmin/bloc.dart';
import 'package:grassport_app/presentation/bloc/loged_user_data/bloc.dart';
import 'package:grassport_app/presentation/router/starting_app_routes.dart';
import 'package:grassport_app/presentation/bloc/startAppBloc/blocs.dart';
import 'package:grassport_app/services/auth_login.dart';
import '../../styles/systemThemes.dart';
import '../../styles/colors.dart';

//ignore: must_be_immutable
class Previews extends StatefulWidget {
  const Previews({super.key});

  @override
  State<Previews> createState() => _StartingPreviews();
}

class _StartingPreviews extends State<Previews> {
  @override
  Widget build(BuildContext context) {
    final currentSwiperIndex = context.watch<NextSwipers>();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemModifiers.overlayLigth,
      child: Scaffold(
        backgroundColor: c1,
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(
                top: 50.0,
              ),
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                key: Key('Preview ${currentSwiperIndex.state}'),
                children: [
                  Swipers(
                    colorSwiper: currentSwiperIndex.state >= 0 ? c8 : c10,
                  ),
                  Swipers(
                    colorSwiper: currentSwiperIndex.state >= 1 ? c8 : c10,
                  ),
                  Swipers(
                    colorSwiper: currentSwiperIndex.state >= 2 ? c8 : c10,
                  ),
                ],
              ),
            ),
            const Expanded(
              child: SwiperInfo(),
            )
          ],
        ),
      ),
    );
  }
}

class Swipers extends StatefulWidget {
  const Swipers({super.key, required this.colorSwiper});

  final Color colorSwiper;

  @override
  State<Swipers> createState() => _StartingSwipers();
}

class _StartingSwipers extends State<Swipers> {
  @override
  Widget build(context) {
    return Container(
      width: 100.0,
      height: 2.0,
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: widget.colorSwiper,
      ),
    );
  }
}

class SwiperInfo extends StatelessWidget {
  const SwiperInfo({super.key});

  @override
  Widget build(context) {
    final swiperInfo = context.read<NextSwipers>().getSwipperInfo();

    return ListView(
      children: [
        Image.asset((swiperInfo["image"] as String)),
        const Gap(60),
        Text(
          (swiperInfo["title"] as String),
          style: const TextStyle(fontSize: 20.0),
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 40.0,
            right: 40.0,
          ),
          child: Column(
            children: [
              Text(
                (swiperInfo["description"] as String),
                style: TextStyle(fontSize: 14.5, color: c11),
                textAlign: TextAlign.center,
              ),
              const Gap(20),
              const ButtonsSkipAndNext()
            ],
          ),
        )
      ],
    );
  }
}

class ButtonsSkipAndNext extends StatefulWidget {
  const ButtonsSkipAndNext({super.key});

  @override
  State<ButtonsSkipAndNext> createState() => _ButtonsSkipAndNextState();
}

class _ButtonsSkipAndNextState extends State<ButtonsSkipAndNext> {
  @override
  void initState() {
    setIsLogged();
    super.initState();
  }

  void goToNextView(
      NextSwipers currentSwiperIndex, BuildContext c, bool isLogged) {
    if (currentSwiperIndex.state == 2) {
      if (isLogged) {
        Navigator.pushNamed(c, routeAgreementLocation);
      } else {
        Navigator.pushNamed(c, routeLogin);
      }
    } else {
      currentSwiperIndex.incrementIndex();
      Navigator.pushNamed(c, routePreviews);
    }
  }

  setIsLogged() async {
    bool isGoogleLogged = await checkIfUserIsSignedIn(context);
    if (!isGoogleLogged) {
      // ignore: use_build_context_synchronously
      await checkIfUserIsSignedInJWT(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentSwiperIndex = context.watch<NextSwipers>();
    UserDisplayed? isLogged = context.watch<LoggedUser>().state;
    bool isAdmin = context.watch<IsAdmin>().state;

    return Column(
      children: [
        TextButton(
          key: const Key('Previews - Next Preview btn'),
          style: TextButton.styleFrom(
              backgroundColor: c8,
              minimumSize: const Size(280, 50),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              )),
          onPressed: () {
            goToNextView(currentSwiperIndex, context, isLogged != null);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                currentSwiperIndex.state >= 2 ? 'Empezar' : 'Siguiente',
                style: TextStyle(color: c1),
              ),
              const Gap(5),
              Image.asset('assets/images/Next.png')
            ],
          ),
        ),
        TextButton(
          onPressed: () {
            if (!isAdmin) {
              if (isLogged != null) {
                Navigator.pushNamed(context, routeAgreementLocation);
              } else {
                Navigator.pushNamed(context, routeLogin);
              }
            } else {
              Navigator.pushNamed(context, routeToAdminPanel);
            }
          },
          child: Text(
            'Saltar',
            style: TextStyle(
              decorationThickness: 2.0,
              decoration: TextDecoration.underline,
              color: c9,
            ),
          ),
        )
      ],
    );
  }
}
