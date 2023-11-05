import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:grassport_app/presentation/components/buttons.dart';
import 'package:grassport_app/presentation/styles/colors.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: CircleAvatar(
              radius: 90,
              backgroundColor: c8,
              child: Icon(
                Icons.camera_alt_outlined,
                size: 100.0,
                color: c1,
              ),
            ),
          ),
          const Gap(30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Wrap(
                  spacing: 5.0,
                  runSpacing: 5.0,
                  children: [
                    Field(
                      hinterText: 'Nombre',
                    ),
                    Field(
                      hinterText: 'Apellido',
                    ),
                    Field(
                      hinterText: 'Telefono',
                    ),
                  ],
                ),
                SizedBox(
                  width: 100,
                  child: CustomButton(
                    next: () {},
                    text: Text(
                      "Editar",
                      style: TextStyle(color: c1),
                    ),
                    bg: c8,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class Field extends StatefulWidget {
  String hinterText;
  Field({super.key, required this.hinterText});

  @override
  State<Field> createState() => _FieldState();
}

class _FieldState extends State<Field> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: TextField(
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: c12,
          hintText: widget.hinterText,
        ),
      ),
    );
  }
}
