import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grassport_app/models/cancha_info.dart';
import 'package:grassport_app/presentation/screens/myPlacesHome/myPlace_posting_view/step1.dart';
import 'package:grassport_app/presentation/screens/myPlacesHome/myPlace_posting_view/step2.dart';
import 'package:grassport_app/presentation/screens/myPlacesHome/myPlace_posting_view/step3.dart';
import 'package:grassport_app/presentation/styles/colors.dart';
import 'package:image_picker/image_picker.dart';

class LocationPostingView extends StatefulWidget {
  @override
  _LocationPostingViewState createState() => _LocationPostingViewState();
}

class _LocationPostingViewState extends State<LocationPostingView> {
  final PageController _pageController = PageController(initialPage: 0);

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

  int completedSteps = 1;

  int FIRST_STEP = 1;
  int SECOND_STEP = 2;
  int THIRD_STEP = 3;

  CanchaInfo cancha1 = CanchaInfo(
    nombre: 'Campo Deportivo Sorana',
    address: 'Misionero Salas 654, Callao',
    description:
        'Laborum sunt magna ipsum ea proident mollit. Ipsum labore occaecat culpa qui officia quis esse qui ex duis id. Tempor aliquip tempor proident occaecat dolor.Laborum sunt magna ipsum ea proident mollit. Ipsum labore occaecat culpa qui officia quis esse qui ex duis id. Tempor aliquip tempor proident occaecat dolor.Laborum sunt magna ipsum ea proident mollit. Ipsum labore occaecat culpa qui officia quis esse qui ex duis id. Tempor aliquip tempor proident occaecat dolor. ',
    isOpen: true,
    location: LatLng(-12.0116547, -77.1024219),
    placeId: '',
    comments: [],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: c15,
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          ListView(
            children: [
              FormStep1(
                onContinue: () {
                  _pageController.animateToPage(
                    1,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );

                  setState(() {
                    completedSteps = 2;
                  });
                },
              ),
            ],
          ),
          LocationPicker(
            onConfirm: () {
              _pageController.animateToPage(
                2,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );

              setState(() {
                completedSteps = 3;
              });
            },
            onPrevious: () {
              _pageController.animateToPage(
                0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );

              setState(() {
                completedSteps = 1;
              });
            },
          ),
          ListView(
            children: [
              PreviewStep3(data: cancha1),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: c8,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CircleAvatar(
                backgroundColor: completedSteps >= FIRST_STEP ? c1 : c8,
                radius: 40,
                child: Text(
                  '1',
                  style: TextStyle(
                    color: completedSteps >= FIRST_STEP ? c8 : c1,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
              const Gap(10),
              DashedLine(
                color: completedSteps >= SECOND_STEP ? c1 : c8,
              ),
              const Gap(10),
              CircleAvatar(
                backgroundColor: completedSteps >= SECOND_STEP ? c1 : c8,
                radius: 40,
                child: Text(
                  '2',
                  style: TextStyle(
                    color: completedSteps >= SECOND_STEP ? c8 : c1,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
              const Gap(10),
              DashedLine(
                color: completedSteps >= THIRD_STEP ? c1 : c8,
              ),
              const Gap(10),
              CircleAvatar(
                backgroundColor: completedSteps >= THIRD_STEP ? c1 : c8,
                radius: 40,
                child: Text(
                  '3',
                  style: TextStyle(
                    color: completedSteps >= THIRD_STEP ? c8 : c1,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashedLine extends StatelessWidget {
  final Color color;

  const DashedLine({
    super.key,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2,
      width: 50,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: color,
            width: 2,
            style: BorderStyle.solid,
          ),
        ),
      ),
    );
  }
}
