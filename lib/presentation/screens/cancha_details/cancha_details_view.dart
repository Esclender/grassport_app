import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:grassport_app/api/api_client.dart';
import 'package:grassport_app/models/cancha_info.dart';
import 'package:grassport_app/models/logged_user.dart';
import 'package:grassport_app/presentation/bloc/loged_user_data/bloc.dart';
import 'package:grassport_app/presentation/components/popus/must_be_logged_pp.dart';
import 'package:grassport_app/presentation/components/popus/succesfull_pp.dart';
import 'package:grassport_app/presentation/components/stars_rating.dart';
import 'package:grassport_app/presentation/screens/cancha_details/comments_section.dart';
import 'package:grassport_app/presentation/styles/boxx_shadows.dart';
import 'package:grassport_app/presentation/styles/colors.dart';

// ignore: must_be_immutable
class CanchaDetails extends StatefulWidget {
  CanchaInfo cancha;

  CanchaDetails({
    super.key,
    required this.cancha,
  });

  @override
  State<CanchaDetails> createState() => _CanchaDetailsState();
}

class _CanchaDetailsState extends State<CanchaDetails> {
  ApiClient myClienet = ApiClient();

  @override
  Widget build(BuildContext context) {
    UserDisplayed? isUserSigned = context.watch<LoggedUser>().state;
    List<Comment> comments = widget.cancha.comments;

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
              _buildOwner(),
              Container(
                height: MediaQuery.of(context).size.height * 0.27,
                width: MediaQuery.of(context).size.width * 0.95,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  image: DecorationImage(
                    image: NetworkImage(widget.cancha.photoURL),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Gap(10),
              DetailsTitles(
                data: widget.cancha,
              ),
              const Gap(20),
              CommentsSection(
                comments: comments,
                placeId: widget.cancha.placeId,
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

  Widget _buildOwner() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Publicado por:",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const Gap(10),
        Row(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  simpleShadow,
                ],
              ),
              child: CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(
                  widget.cancha.ownerURL,
                ),
              ),
            ),
            Text(
              "${widget.cancha.ownerName}",
              style: TextStyle(
                color: c8,
              ),
            ),
          ],
        ),
        const Gap(10),
      ],
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
            Text(
              data.address,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w200,
              ),
            ),
            StarsRating(
              canchaUpdate: () {},
              rate: data.rating,
              isDetails: false,
            ),
            const Gap(10),
            Text(
              data.description,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w100,
              ),
            ),
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
