import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:grassport_app/presentation/bloc/nearCanchas/blocs.dart';
import 'package:grassport_app/presentation/components/cancha_card.dart';
import 'package:grassport_app/presentation/styles/colors.dart';

class MainAppHomeLayer extends StatefulWidget {
  const MainAppHomeLayer({super.key});

  @override
  State<MainAppHomeLayer> createState() => _MainAppHomeLayerState();
}

class _MainAppHomeLayerState extends State<MainAppHomeLayer> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Image.asset(
            "assets/images/Street_bg.png",
            fit: BoxFit.cover,
          ),
        ),
        const BottomModal(),
      ],
    );
  }
}

class BottomModal extends StatefulWidget {
  const BottomModal({super.key});

  @override
  State<BottomModal> createState() => _BottomModalState();
}

class _BottomModalState extends State<BottomModal> {
  @override
  Widget build(BuildContext context) {
    var nearCanchas = context.watch<NearCanchas>();

    return DraggableScrollableSheet(
      initialChildSize: 0.15,
      minChildSize: 0.15,
      maxChildSize: 1.0,
      builder: (context, scrollcontroller) {
        return Container(
          decoration: BoxDecoration(
            color: c1,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: MediaQuery.of(context).size.width * 0.45,
                child: Icon(
                  Icons.keyboard_arrow_up_rounded,
                  color: c8,
                  size: 40,
                ),
              ),
              Container(
                child: ListCanchas(
                  scrollController: scrollcontroller,
                  canchasArray: nearCanchas.state,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ignore: must_be_immutable
class ListCanchas extends StatelessWidget {
  ScrollController scrollController;

  List canchasArray;

  ListCanchas(
      {super.key, required this.scrollController, required this.canchasArray});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemCount: canchasArray.length,
      itemBuilder: (context, ind) {
        if (ind == canchasArray.length - 1) {
          return Column(
            children: [
              CanchaCard(
                data: canchasArray[ind],
              ),
              const Gap(100),
            ],
          );
        } else {
          return CanchaCard(
            data: canchasArray[ind],
          );
        }
      },
    );
  }
}
