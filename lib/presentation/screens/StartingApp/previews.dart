import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:grassport_app/presentation/router/starting_app_routes.dart';
import 'package:grassport_app/presentation/bloc/startAppBloc/blocs.dart';
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
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemModifiers.overlayLigth);
  }

  @override
  Widget build(BuildContext context) {
    final currentSwiperIndex = context.watch<NextSwipers>();

    return Scaffold(
      backgroundColor: c1,
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(
              top: 50.0,
              left: 20.0,
              right: 20.0,
            ),
            alignment: Alignment.topCenter,
            child: Row(
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
          const SwiperInfo(),
        ],
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

    return Container(
      margin: const EdgeInsets.only(
        top: 150.0,
        left: 40.0,
        right: 40.0,
      ),
      child: Column(
        children: [
          Image.asset((swiperInfo["image"] as String)),
          const Gap(60),
          Text(
            (swiperInfo["title"] as String),
            style: const TextStyle(fontSize: 20.0),
            textAlign: TextAlign.center,
          ),
          Text(
            (swiperInfo["description"] as String),
            style: TextStyle(fontSize: 14.5, color: c11),
            textAlign: TextAlign.center,
          ),
          const Gap(20),
          const ButtonsSkipAndNext()
        ],
      ),
    );
  }
}

class ButtonsSkipAndNext extends StatelessWidget {
  const ButtonsSkipAndNext({super.key});

  @override
  Widget build(BuildContext context) {
    final currentSwiperIndex = context.watch<NextSwipers>();

    return Column(
      children: [
        TextButton(
          style: TextButton.styleFrom(
              backgroundColor: c8,
              minimumSize: const Size(280, 50),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              )),
          onPressed: () {
            if (currentSwiperIndex.state == 2) {
              Navigator.pushNamed(context, routeLogin);
            } else {
              currentSwiperIndex.incrementIndex();
              Navigator.pushNamed(context, routePreviews);
            }
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
            Navigator.pushNamed(context, routeLogin);
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
