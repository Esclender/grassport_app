import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:page_transition/page_transition.dart';
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
          SwiperInfo(
            fatherContext: context,
          ),
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
  final BuildContext fatherContext;
  const SwiperInfo({super.key, required this.fatherContext});

  @override
  Widget build(context) {
    final swiperInfo = context.watch<NextSwipers>().getSwipperInfo();

    return BlocListener<NextSwipers, int>(
      listener: (context, state) {
        Navigator.push(
          fatherContext,
          PageTransition(
            type: PageTransitionType
                .rightToLeft, // Define your custom transition type
            duration: const Duration(seconds: 2), // Set the transition duration
            child: const Previews(),
          ),
        );
      },
      child: Container(
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
              style: const TextStyle(fontFamily: 'blinker', fontSize: 20.0),
              textAlign: TextAlign.center,
            ),
            Text(
              (swiperInfo["description"] as String),
              style:
                  TextStyle(fontFamily: 'blinker', fontSize: 14.5, color: c11),
              textAlign: TextAlign.center,
            ),
            const Gap(20),
            const ButtonsSkipAndNext()
          ],
        ),
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
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: FloatingActionButton(
            heroTag: 'btn_next_swiper',
            backgroundColor: c8,
            onPressed: () {
              currentSwiperIndex.setSwiperIndex(currentSwiperIndex.state + 1);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Siguiente',
                  style: TextStyle(color: c1),
                ),
                const Gap(5),
                Image.asset('assets/images/Next.png')
              ],
            ),
          ),
        ),
        FloatingActionButton(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          onPressed: () {},
          child: const Text(
            'Saltar',
            style: TextStyle(
              decorationThickness: 2.0,
              decoration: TextDecoration.underline,
            ),
          ),
        )
      ],
    );
  }
}
