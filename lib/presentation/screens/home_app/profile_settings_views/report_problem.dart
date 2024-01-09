import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grassport_app/api/api_client.dart';
import 'package:grassport_app/presentation/components/buttons.dart';
import 'package:grassport_app/presentation/components/alerts.dart';
import 'package:grassport_app/presentation/styles/colors.dart';
import 'package:image_picker/image_picker.dart';

class ReportProblem extends StatefulWidget {
  const ReportProblem({super.key});

  @override
  State<ReportProblem> createState() => _ReportProblemState();
}

class _ReportProblemState extends State<ReportProblem> {
  TextEditingController textAreaController = TextEditingController();
  String text = "Sube una foto de tu problema";

  @override
  void initState() {
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

  cleanFields() {
    setState(() {
      textAreaController.clear();
      imageFile = null;
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
              _buildImageField(),
              TextField(
                keyboardType: TextInputType.text,
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
                    try {
                      CustomDialogs.showSearchingDialog(
                          context, 'Subiendo Reporte...');

                      await ApiClient().reportProblem(
                        imageFile as File,
                        textAreaController.value.text,
                      );
                    } finally {
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                      // ignore: use_build_context_synchronously
                      CustomDialogs.showSearchingDialog(
                          context, 'Reporte Subido...');

                      Timer(const Duration(seconds: 1), () {
                        Navigator.pop(context);
                        cleanFields();
                      });
                    }
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

  Widget _buildImageField() {
    return CustomButton(
      next: () async {
        var imageName = await selectImage(ImageSource.gallery);

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
