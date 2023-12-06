import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:grassport_app/api/api_client.dart';
import 'package:grassport_app/models/user_profile.dart';
import 'package:grassport_app/presentation/bloc/loged_user_data/bloc.dart';
import 'package:grassport_app/presentation/components/buttons.dart';
import 'package:grassport_app/presentation/components/popus/succesfull_pp.dart';
import 'package:grassport_app/presentation/styles/colors.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nombreController = TextEditingController();
  TextEditingController apellidoController = TextEditingController();
  TextEditingController telefonoController = TextEditingController();

  @override
  void initState() {
    setUserData();
    super.initState();
  }

  setUserData() async {
    UserProfile userLogged = await ApiClient().getUserData();

    nombreController.value = TextEditingValue(text: userLogged.nombre);
    apellidoController.value = TextEditingValue(text: userLogged.apellido);
    telefonoController.value = TextEditingValue(text: userLogged.numero);
  }

  void updateUserData() async {
    UserProfile userToUpdate = UserProfile(
        nombre: nombreController.text,
        apellido: apellidoController.text,
        numero: telefonoController.text);

    await ApiClient().saveUserData(user: userToUpdate);
  }

  @override
  Widget build(BuildContext context) {
    User? userData = context.watch<LoggedUser>().state;

    return Scaffold(
      appBar: AppBar(),
      body: Form(
        // Wrap everything in a Form
        key: _formKey, // Set the key
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: CircleAvatar(
                radius: 90,
                backgroundColor: c8,
                backgroundImage: NetworkImage(userData?.photoURL as String),
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
                        controller: nombreController,
                        hinterText: 'Nombre',
                      ),
                      Field(
                        controller: apellidoController,
                        hinterText: 'Apellido',
                      ),
                      Field(
                        controller: telefonoController,
                        hinterText: 'Telefono',
                        isPhoneNumber: true,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 100,
                    child: CustomButton(
                      next: () {
                        if (_formKey.currentState!.validate()) {
                          updateUserData();
                          showDialog(
                            barrierColor: Colors.transparent,
                            context: context,
                            builder: (context) => SuccesfullPopup(
                              message: 'Datos actualizados',
                              bg: c11,
                            ),
                          );
                        }
                      },
                      text: Text(
                        "Editar",
                        style: TextStyle(color: c1),
                      ),
                      bg: c8,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class Field extends StatefulWidget {
  String hinterText;
  TextEditingController controller;
  bool isPhoneNumber;

  Field({
    super.key,
    required this.hinterText,
    required this.controller,
    this.isPhoneNumber = false,
  });

  @override
  State<Field> createState() => _FieldState();
}

class _FieldState extends State<Field> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: TextFormField(
        controller: widget.controller,
        keyboardType:
            widget.isPhoneNumber ? TextInputType.phone : TextInputType.text,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: c12,
          hintText: widget.hinterText,
          counter:
              const SizedBox.square(), // Hide the default character counter
        ),
        maxLength: widget.isPhoneNumber
            ? 9
            : null, // Adjust the max length for a phone number
        validator: (value) {
          if (widget.isPhoneNumber && value!.length < 9) {
            return 'Telefono Incorrecto';
          }
          return null;
        },
      ),
    );
  }
}
