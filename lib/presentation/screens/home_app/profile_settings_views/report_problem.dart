import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grassport_app/api/api_client.dart';
import 'package:grassport_app/presentation/components/buttons.dart';
import 'package:grassport_app/presentation/router/starting_app_routes.dart';
import 'package:grassport_app/presentation/styles/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

class ReportProblem extends StatefulWidget {
  const ReportProblem({super.key});

  @override
  State<ReportProblem> createState() => _ReportProblemState();
}

class _ReportProblemState extends State<ReportProblem> {
  TextEditingController textAreaController = TextEditingController();
  ProgressDialog? pr;

  @override
  void initState() {
    setPr();
    super.initState();
  }

  ImagePicker imagePicker = ImagePicker();
  File? imageFile;

  Future selectImage(ImageSource imageSource) async {
    XFile? image = await imagePicker.pickImage(source: imageSource);
    if (image != null) {
      imageFile = File(image.path);
      return image.name;
    }
  }

  setPr() {
    setState(() {
      pr = pr = ProgressDialog(context, showLogs: true, isDismissible: false);
      pr?.style(
        message: 'Subiendo reporte...',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Wrap(
            alignment: WrapAlignment.end,
            runSpacing: 10.0,
            children: [
              Field(
                imageController: selectImage,
              ),
              // const Field(),
              // const Field(),
              TextField(
                maxLines: 8,
                controller: textAreaController,
                decoration: InputDecoration(
                  hintText: "Describe tu problema",
                  filled: true,
                  fillColor: c12,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(
                width: 150,
                child: CustomButton(
                  next: () async {
                    pr?.show();
                    Future.delayed(const Duration(seconds: 4)).then((value) {
                      pr?.update(message: 'Reporte subido!');

                      Future.delayed(const Duration(seconds: 2), () {
                        pr?.hide().whenComplete(() {
                          Future.delayed(
                            const Duration(seconds: 1),
                          ).then((v) {
                            Navigator.pushNamed(context, routeHomeApp);
                          });
                        });
                      });
                    });

                    await ApiClient().reportProblem(
                      imageFile as File,
                      textAreaController.value.text,
                    );
                  },
                  text: Text(
                    "Enviar",
                    style: TextStyle(color: c1),
                  ),
                  bg: c8,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class Field extends StatefulWidget {
  Function imageController;
  Field({super.key, required this.imageController});

  @override
  State<Field> createState() => _FieldState();
}

class _FieldState extends State<Field> {
  String text = "Sube una foto de tu problema";

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      next: () async {
        var imageName = await widget.imageController(ImageSource.gallery);

        setState(() {
          text = imageName;
        });
      },
      text: Row(
        children: [
          Text(
            text,
            style: TextStyle(color: c18),
          ),
          Icon(
            Icons.upload,
            color: c18,
          )
        ],
      ),
      bg: c12,
    );
  }
}
