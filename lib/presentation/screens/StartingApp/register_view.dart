import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:grassport_app/presentation/components/code_confirmation_modal.dart';
import 'package:grassport_app/presentation/styles/colors.dart';
import 'package:grassport_app/presentation/styles/systemThemes.dart';
import 'package:grassport_app/services/auth_login.dart';
import 'package:image_picker/image_picker.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _numeroTlfController = TextEditingController();
  final TextEditingController _claveController = TextEditingController();
  final TextEditingController _confirmarClaveController =
      TextEditingController();

  ImagePicker imagePicker = ImagePicker();
  File? imageFile;
  late int code;
  int expirationTime = 0;
  bool isBottomSheetVisible = false;

  Future selectImage(ImageSource imageSource) async {
    XFile? image = await imagePicker.pickImage(source: imageSource);
    if (image != null) {
      setState(() {
        imageFile = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemModifiers.overlayDark,
        child: Scaffold(
          backgroundColor: c8,
          body: Stack(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                    children: [
                      const Gap(40),
                      uploadPicture(),
                      SizedBox(
                        width: 300,
                        child: TextField(
                          controller: _emailController,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(color: Colors.white),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            suffixIcon: Icon(
                              Icons.email,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Container(
                        width: 300,
                        child: TextField(
                          controller: _nombreController,
                          style: TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            labelText: 'Nombre',
                            labelStyle: TextStyle(color: Colors.white),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            suffixIcon: Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      // Apellido TextField
                      Container(
                        width: 300,
                        child: TextField(
                          controller: _apellidoController,
                          style: TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            labelText: 'Apellido',
                            labelStyle: TextStyle(color: Colors.white),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            suffixIcon: Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      // Numero Tlf TextField
                      Container(
                        width: 300,
                        child: TextField(
                          maxLength: 9,
                          controller: _numeroTlfController,
                          style: TextStyle(color: Colors.white),
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            labelText: 'Numero Tlf',
                            labelStyle: TextStyle(color: Colors.white),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            suffixIcon: Icon(
                              Icons.phone,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      // Clave and Confirmar Clave TextFields in a Row
                      Row(
                        children: [
                          // Clave TextField
                          Expanded(
                            child: SizedBox(
                              child: TextField(
                                controller: _claveController,
                                style: const TextStyle(color: Colors.white),
                                decoration: const InputDecoration(
                                  labelText: 'Clave',
                                  labelStyle: TextStyle(color: Colors.white),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  suffixIcon: Icon(
                                    Icons.lock,
                                    color: Colors.white,
                                  ),
                                ),
                                obscureText: true,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          // Confirmar Clave TextField
                          Expanded(
                            child: SizedBox(
                              child: TextField(
                                controller: _confirmarClaveController,
                                style: const TextStyle(color: Colors.white),
                                decoration: const InputDecoration(
                                  labelText: 'Confirmar Clave',
                                  labelStyle: TextStyle(color: Colors.white),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  suffixIcon: Icon(
                                    Icons.lock,
                                    color: Colors.white,
                                  ),
                                ),
                                obscureText: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      ElevatedButton.icon(
                        onPressed: () async {
                          if (_validateEmail() && _validatePhoneNumber()) {
                            _checkFieldsNotEmpty();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                        ),
                        icon: Icon(
                          Icons.person_add,
                          color: c8,
                        ),
                        label: Text(
                          'Register',
                          style: TextStyle(color: c8),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              isBottomSheetVisible
                  ? IgnorePointer(
                      ignoring: isBottomSheetVisible,
                      child: ModalBarrier(
                        color: Colors.black.withOpacity(0.5),
                        dismissible: true,
                      ),
                    )
                  : Container(),
              isBottomSheetVisible
                  ? Positioned(bottom: 0, child: codeConfirmation())
                  : Container()
            ],
          ),
        ),
      ),
    );
  }

  Widget codeConfirmation() {
    onCodeConfirmed() {
      _emailController.clear();
      _nombreController.clear();
      _apellidoController.clear();
      _numeroTlfController.clear();
      _claveController.clear();
      _confirmarClaveController.clear();

      setState(() {
        isBottomSheetVisible = false;
        imageFile = null;
      });

      _showSuccessDialog();
    }

    onCancel() {
      _showAlert('Codigo no es correcto');
    }

    return CodeConfirmationWidget(
      onCodeConfirmed: onCodeConfirmed,
      onCancel: onCancel,
      code: code,
      expirationTime: expirationTime,
      phoneNumber: _numeroTlfController.text,
    );
  }

  Widget uploadPicture() {
    return GestureDetector(
      onTap: () async {
        await selectImage(ImageSource.gallery);
      },
      child: Center(
        child: imageFile == null
            ? CircleAvatar(
                radius: 60,
                backgroundColor: c1,
                child: const Icon(
                  Icons.camera_alt_outlined,
                  size: 40,
                ),
              )
            : CircleAvatar(
                radius: 60,
                backgroundImage: FileImage(imageFile!),
              ),
      ),
    );
  }

  void _checkFieldsNotEmpty() {
    if (_emailController.text.isEmpty ||
        _nombreController.text.isEmpty ||
        _apellidoController.text.isEmpty ||
        _numeroTlfController.text.isEmpty ||
        _claveController.text.isEmpty ||
        _confirmarClaveController.text.isEmpty ||
        imageFile == null) {
      _showAlert('Llena todos los campos');
    } else {
      // All fields are filled, continue with registration logic
      _verifyPasswordsAndRegister();
    }
  }

  void _verifyPasswordsAndRegister() async {
    String email = _emailController.text.trim();
    String password = _claveController.text.trim();
    String nombre = _nombreController.text.trim();
    String apellido = _apellidoController.text.trim();
    String numeroTlf = _numeroTlfController.text.trim();
    String confirmarClave = _confirmarClaveController.text.trim();

    if (password != confirmarClave) {
      _showAlert('Claves no son iguales');
    } else {
      Map confirmationDta = await registerUser(
        email: email,
        password: password,
        nombre: nombre,
        apellido: apellido,
        numero: numeroTlf,
        image: imageFile as File,
      );

      setState(() {
        code = confirmationDta["verificationCode"];
        expirationTime = confirmationDta["expirationTime"];
        isBottomSheetVisible = true;
      });

      //_showSuccessDialog();
    }
  }

  bool _validateEmail() {
    String email = _emailController.text.trim();
    if (RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
        .hasMatch(email)) {
      return true;
    } else {
      _showAlert('Ingrese un email válido');
      return false;
    }
  }

  bool _validatePhoneNumber() {
    String phoneNumber = _numeroTlfController.text.trim();
    if (phoneNumber.length >= 9) {
      return true;
    } else {
      _showAlert('Ingrese un número de teléfono válido (mínimo 9 dígitos)');
      return false;
    }
  }

  void _showAlert(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.warning, color: Colors.green),
              SizedBox(width: 8.0),
              Text('Alerta', style: TextStyle(color: Colors.green)),
            ],
          ),
          content: Text(message, style: const TextStyle(color: Colors.green)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK', style: TextStyle(color: Colors.green)),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green),
              SizedBox(width: 8.0),
              Text('Registro Exitoso', style: TextStyle(color: Colors.green)),
            ],
          ),
          content: const Text('Te has registrado exitosamente.',
              style: TextStyle(color: Colors.green)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK', style: TextStyle(color: Colors.green)),
            ),
          ],
        );
      },
    );
  }
}
