import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import '../../styles/systemThemes.dart';
import '../../styles/colors.dart';

//ignore: must_be_immutable
class Previews extends StatefulWidget {
  const Previews({super.key});

  @override
  State<Previews> createState() => _StartingPreviews();
}

class _StartingPreviews extends State<Previews> {
  int _currentSwiper = 0;

  void _nextSwiper() {
    setState(() {
      _currentSwiper += 1;
    });
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemModifiers.overlayLigth);
  }

  @override
  Widget build(BuildContext context) {
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
                    colorSwiper: _currentSwiper >= 0 ? c8 : c10,
                  ),
                  Swipers(
                    colorSwiper: _currentSwiper >= 1 ? c8 : c10,
                  ),
                  Swipers(
                    colorSwiper: _currentSwiper >= 2 ? c8 : c10,
                  ),
                ],
              )),
          Container(
            margin: const EdgeInsets.only(top: 150.0),
            child: Image.asset('assets/images/images-lorem.png'),
          ),
          const Gap(20),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: FloatingActionButton(
              heroTag: 'btn_next_swiper',
              backgroundColor: c8,
              onPressed: _nextSwiper,
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
