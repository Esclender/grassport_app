import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:grassport_app/api/api_client.dart';
import 'package:grassport_app/models/cancha_info.dart';
import 'package:grassport_app/models/logged_user.dart';
import 'package:grassport_app/presentation/bloc/loged_user_data/bloc.dart';
import 'package:grassport_app/presentation/components/map.dart';
import 'package:grassport_app/presentation/components/popus/must_be_logged_pp.dart';
import 'package:grassport_app/presentation/components/popus/succesfull_pp.dart';
import 'package:grassport_app/presentation/components/stars_rating.dart';
import 'package:grassport_app/presentation/styles/colors.dart';

// ignore: must_be_immutable
class CanchaDetails extends StatefulWidget {
  CanchaInfo cancha;
  CanchaDetails({super.key, required this.cancha});

  @override
  State<CanchaDetails> createState() => _CanchaDetailsState();
}

class _CanchaDetailsState extends State<CanchaDetails> {
  @override
  Widget build(BuildContext context) {
    UserDisplayed? isUserSigned = context.watch<LoggedUser>().state;

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.27,
                width: MediaQuery.of(context).size.width * 0.95,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://ichef.bbci.co.uk/news/640/cpsprodpb/238D/production/_95410190_gettyimages-488144002.jpg'),
                      fit: BoxFit.cover),
                ),
              ),
              const Gap(10),
              DetailsTitles(
                data: widget.cancha,
              ),
              const Gap(10),
              Text(
                widget.cancha.address,
                style: const TextStyle(fontSize: 18),
              ),
              StreetMap(
                location: widget.cancha.location,
              ),
              const Gap(15),
              ActionBtns(
                dataCancha: widget.cancha,
                isSigned: isUserSigned != null,
              )
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class DetailsTitles extends StatelessWidget {
  CanchaInfo data;
  DetailsTitles({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 200,
              child: Text(
                data.nombre,
                style: TextStyle(color: c9, fontSize: 20),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            StarsRating(
              canchaUpdate: () {},
              rate: data.rating,
              isDetails: false,
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data.isOpen ? "Abierto" : 'Cerrado',
              style: data.isOpen
                  ? TextStyle(
                      color: c8,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )
                  : TextStyle(
                      color: c4,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
            )
          ],
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class ActionBtns extends StatelessWidget {
  CanchaInfo dataCancha;
  bool isSigned;

  ActionBtns({super.key, required this.dataCancha, required this.isSigned});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          onPressed: () async {
            if (isSigned) {
              await ApiClient().saveFavorite(lugar: dataCancha);

              // ignore: use_build_context_synchronously
              showDialog(
                barrierColor: Colors.transparent,
                context: context,
                builder: (context) => SuccesfullPopup(),
              );
            } else {
              // ignore: use_build_context_synchronously
              showDialog(
                barrierColor: Colors.transparent,
                context: context,
                builder: (context) => MustBeLoggedPopup(
                  warningMessage: " Inicia sesion para guardar",
                ),
              );

              // Close the dialog after a delay
              Future.delayed(const Duration(seconds: 2), () {
                Navigator.of(context).pop();
              });
            }
          },
          style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            backgroundColor: c14,
            foregroundColor: c1,
            padding: const EdgeInsets.all(0.0),
          ),
          child: const Icon(
            Icons.bookmark_outline,
            size: 35.0,
          ),
        ),
      ],
    );
  }
}
//"assets/app_icons/whatsapp.svg"