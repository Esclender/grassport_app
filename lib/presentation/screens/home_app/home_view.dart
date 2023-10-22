import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:grassport_app/presentation/bloc/nearCanchas/blocs.dart';
import 'package:grassport_app/presentation/components/cancha_card.dart';
import 'package:grassport_app/presentation/components/home_badget.dart';
import 'package:grassport_app/presentation/styles/colors.dart';

class HomeApp extends StatefulWidget {
  const HomeApp({super.key});

  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: c8,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Stack(
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
          Positioned(
            bottom: 50,
            left: MediaQuery.of(context).size.width * 0.23,
            child: const HomeBadget(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 60),
                child: SearchBar(
                  hintText: "Buscar por canchas",
                  hintStyle: MaterialStateProperty.all(
                    const TextStyle(color: Color.fromARGB(141, 158, 158, 158)),
                  ),
                  backgroundColor: MaterialStateProperty.all(c1),
                  elevation: MaterialStateProperty.all(1.0),
                  surfaceTintColor: MaterialStateProperty.all(c1),
                  constraints:
                      const BoxConstraints(maxWidth: 300, minHeight: 50),
                  leading: const Icon(Icons.search),
                ),
              ),
              const Avatar(),
            ],
          ),
        ],
      ),
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
              Expanded(
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
        return CanchaCard(
          data: canchasArray[ind],
        );
      },
    );
  }
}

class Avatar extends StatelessWidget {
  const Avatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60),
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
    );
  }
}
