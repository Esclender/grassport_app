import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grassport_app/models/cancha_info.dart';
import 'package:grassport_app/presentation/components/map.dart';
import 'package:grassport_app/presentation/components/stars_rating.dart';
import 'package:grassport_app/presentation/screens/cancha_details/comments_section.dart';
import 'package:grassport_app/presentation/styles/colors.dart';

// ignore: must_be_immutable
class MyPlaceCanchasDetail extends StatefulWidget {
  CanchaInfo data;

  MyPlaceCanchasDetail({
    super.key,
    required this.data,
  });

  @override
  State<MyPlaceCanchasDetail> createState() => _MyPlaceCanchasDetailState();
}

class _MyPlaceCanchasDetailState extends State<MyPlaceCanchasDetail> {
  TextEditingController _titleEditingController = TextEditingController();
  TextEditingController _addressEditingController = TextEditingController();
  TextEditingController _descripcionEditingController = TextEditingController();
  bool isOpen = false;

  @override
  void initState() {
    super.initState();

    setForms();
  }

  void setForms() {
    setState(() {
      _titleEditingController = TextEditingController(
        text: widget.data.nombre,
      );
      _addressEditingController = TextEditingController(
        text: widget.data.address,
      );
      _descripcionEditingController = TextEditingController(
        text: widget.data.description,
      );

      isOpen = widget.data.isOpen;
    });
  }

  List<Comment> comments = [
    Comment(
      replies: [],
      name: "Esclender",
      comment:
          "Eu proident nostrud ex sunt Lorem anim duis esse consequat. Ullamco amet qui velit quis ad ipsum officia officia magna. Qui adipisicing commodo irure dolore cillum qui anim culpa nulla tempor do ut. Magna exercitation ullamco sint aute pariatur commodo cupidatat id quis esse sit ex. Culpa adipisicing esse eu ipsum culpa.",
      profilePicture:
          'https://firebasestorage.googleapis.com/v0/b/grassportapp-7ccb1.appspot.com/o/usuarios%2F1703518477729.jpg?alt=media&token=17c34920-964e-4c7c-8ede-58bfdd1b3f78',
    ),
    Comment(
      replies: [],
      name: "Esclender",
      comment: "Comentario",
      profilePicture:
          'https://firebasestorage.googleapis.com/v0/b/grassportapp-7ccb1.appspot.com/o/usuarios%2F1703518477729.jpg?alt=media&token=17c34920-964e-4c7c-8ede-58bfdd1b3f78',
    ),
    Comment(
      replies: [],
      name: "Esclender",
      comment: "Comentario",
      profilePicture:
          'https://firebasestorage.googleapis.com/v0/b/grassportapp-7ccb1.appspot.com/o/usuarios%2F1703518477729.jpg?alt=media&token=17c34920-964e-4c7c-8ede-58bfdd1b3f78',
    ),
    Comment(
      replies: [],
      name: "Esclender",
      comment: "Comentario",
      profilePicture:
          'https://firebasestorage.googleapis.com/v0/b/grassportapp-7ccb1.appspot.com/o/usuarios%2F1703518477729.jpg?alt=media&token=17c34920-964e-4c7c-8ede-58bfdd1b3f78',
    ),
    Comment(
      replies: [],
      name: "Esclender",
      comment: "Comentario",
      profilePicture:
          'https://firebasestorage.googleapis.com/v0/b/grassportapp-7ccb1.appspot.com/o/usuarios%2F1703518477729.jpg?alt=media&token=17c34920-964e-4c7c-8ede-58bfdd1b3f78',
    ),
    Comment(
      replies: [],
      name: "Esclender",
      comment: "Comentario",
      profilePicture:
          'https://firebasestorage.googleapis.com/v0/b/grassportapp-7ccb1.appspot.com/o/usuarios%2F1703518477729.jpg?alt=media&token=17c34920-964e-4c7c-8ede-58bfdd1b3f78',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back_rounded,
          color: c1,
          weight: 20,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
      body: Stack(
        children: [
          Stack(
            alignment: Alignment.centerRight,
            children: [
              Image.network(
                'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=AWU5eFi0Qs7QRGzA3t-GZjvnpzggQKk8iPUfercxGKMG4br5mMdJ-I7kjQPs6zR49a8Iv9DpEA_BXJBC67UKRSPRtQi9R4FCLzTOsnAen8-f-QaIX3CaFAVNY95ep9FEi5P8G39WVa_jHQQOD1EzsvIgx_GeaS1w10wThHOSW37rmL2IVy4Q&key=AIzaSyDqtTbNkH59t_Ia6vzUGTH7vNAXaeL8g0Q',
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 55, right: 20),
                height: 45,
                width: 45,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: c1.withOpacity(0.3),
                  ),
                  child: Icon(
                    Icons.fullscreen_exit_sharp,
                    color: c1,
                  ),
                ),
              ),
            ],
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.5,
            maxChildSize: 0.9,
            minChildSize: 0.5,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: c8,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: _canchaDetailsInfo(scrollController),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _canchaDetailsInfo(ScrollController sc) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: ListView(
        controller: sc,
        children: [
          _buildEditableRow(
              widget.data.nombre,
              TextStyle(
                color: c1,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
              _titleEditingController,
              'Editar Nombre'),
          _buildEditableRow(
              widget.data.address,
              TextStyle(
                color: c1,
                fontWeight: FontWeight.w200,
              ),
              _addressEditingController,
              'Editar Direccion'),
          const Gap(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StarsRating(
                canchaUpdate: () {},
                rate: 5,
                isDetails: true,
              ),
              _switch(),
            ],
          ),
          const Gap(10),
          _buildEditableRow(
              'Descripcion',
              TextStyle(
                fontWeight: FontWeight.bold,
                color: c1,
              ),
              _descripcionEditingController,
              'Editar Descripcion'),
          const Gap(10),
          Text(
            widget.data.description,
            style: TextStyle(
              color: c1,
              fontWeight: FontWeight.w200,
            ),
          ),
          const Gap(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CommentsSection(
              commentsCount: comments.length,
              comments: comments,
              isOwner: true,
            ),
          ),
          const Gap(20),
          StreetMap(
            location: LatLng(-12.0116547, -77.1024219),
          )
        ],
      ),
    );
  }

  _showDialog(
    BuildContext context,
    TextEditingController formController,
    String text,
    String editTitle,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: c8,
          title: Text(
            editTitle,
            style: TextStyle(color: c1),
          ),
          content: SizedBox(
            width: 300,
            child: TextField(
              maxLines: 10,
              controller: formController,
              style: TextStyle(color: c1),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: c1,
                    width: 2.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: c1,
                    width: 2.0,
                  ),
                ),
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                // Access the entered text using _textEditingController.text
                String enteredText = formController.text;
                print('Entered Text: $enteredText');
                Navigator.of(context).pop();
              },
              child: Text('Editar'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildEditableRow(
    String text,
    TextStyle sty,
    TextEditingController formCont,
    String editTitle,
  ) {
    return Row(
      children: [
        Expanded(
          child: Text(
            text,
            style: sty,
          ),
        ),
        IconButton(
          onPressed: () {
            _showDialog(
              context,
              formCont,
              text,
              editTitle,
            );
          },
          icon: Icon(
            Icons.edit,
            color: c1,
          ),
        ),
      ],
    );
  }

  Widget _switch() {
    double WIDTH = 110.0;
    double HEIGHT = 55.0;
    return GestureDetector(
      onTap: () {
        setState(() {
          isOpen = !isOpen;
        });
      },
      child: Container(
        margin: EdgeInsets.only(right: 10),
        width: WIDTH,
        height: HEIGHT,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: c1,
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              left: isOpen ? WIDTH / 2 : 0,
              duration: const Duration(milliseconds: 300),
              child: Container(
                width: WIDTH / 2,
                height: HEIGHT,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: isOpen ? Colors.green : Colors.red,
                ),
                child: Center(
                  child: Text(
                    isOpen ? "Abierto" : "Cerrado",
                    style: TextStyle(
                      color: c1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
