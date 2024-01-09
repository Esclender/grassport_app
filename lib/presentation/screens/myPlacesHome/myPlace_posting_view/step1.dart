import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:grassport_app/presentation/components/alerts.dart';
import 'package:grassport_app/presentation/styles/colors.dart';
import 'package:image_picker/image_picker.dart';

class FormStep1 extends StatefulWidget {
  final Function onContinue;

  const FormStep1({
    super.key,
    required this.onContinue,
  });

  @override
  State<FormStep1> createState() => _FormStep1State();
}

class _FormStep1State extends State<FormStep1> {
  late TextEditingController nameController;
  late TextEditingController addressController;
  late TextEditingController descriptionController;

  ImagePicker imagePicker = ImagePicker();
  File? imageFile;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    addressController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future selectImage(ImageSource imageSource) async {
    XFile? image = await imagePicker.pickImage(source: imageSource);
    if (image != null) {
      setState(() {
        imageFile = File(image.path);
      });
    }
  }

  void nextStep() {
    if (nameController.text.isNotEmpty &&
        addressController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
        imageFile != null) {
      widget.onContinue();
    } else {
      CustomDialogs.showAlert(
        context: context,
        title: 'Validar campos',
        message: 'Llena todos los campos',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DottedBorder(
            dashPattern: [8, 4],
            strokeWidth: 2,
            color: c1,
            child: GestureDetector(
              onTap: () async {
                await selectImage(ImageSource.gallery);
              },
              child: Container(
                width: double.infinity,
                height: 200,
                decoration: imageFile != null
                    ? BoxDecoration(
                        image: DecorationImage(
                          image: FileImage(imageFile!),
                          fit: BoxFit.cover,
                        ),
                      )
                    : null,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.camera_alt,
                      color: c1,
                    ),
                    Text(
                      'Subir Foto',
                      style: TextStyle(color: c1),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Gap(16),
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'Nombre de la cancha',
              labelStyle: TextStyle(color: c1),
              fillColor: c8,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
            style: TextStyle(color: c1),
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: addressController,
            decoration: InputDecoration(
              labelText: 'Direccion',
              labelStyle: TextStyle(color: c1),
              fillColor: c8,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
            style: TextStyle(color: c1),
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: descriptionController,
            maxLines: 3,
            decoration: InputDecoration(
              labelText: 'Descripcion',
              labelStyle: TextStyle(color: c1),
              fillColor: c8,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
            style: TextStyle(color: c1),
          ),
          ElevatedButton(
            onPressed: () {
              nextStep();
            },
            child: Text(
              'Continuar',
              style: TextStyle(color: c15, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
