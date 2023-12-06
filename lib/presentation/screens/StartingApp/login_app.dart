import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grassport_app/presentation/bloc/loged_user_data/bloc.dart';
import 'package:grassport_app/presentation/router/starting_app_routes.dart';
import 'package:grassport_app/presentation/styles/colors.dart';
import 'package:grassport_app/presentation/styles/systemThemes.dart';
import 'package:grassport_app/services/auth_login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemModifiers.overlayDark,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: c8,
            automaticallyImplyLeading: false,
          ),
          backgroundColor: c8,
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/Logo.png'),
                      Text(
                        'Grassport',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w300,
                          fontFamily: 'blinker',
                          color: c1,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      // Email TextField with Icon on the right
                      SizedBox(
                        width: 300, // Specify the desired width
                        child: TextField(
                          controller: _emailController,
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
                      // Password TextField with Icon on the right
                      SizedBox(
                        width: 300, // Specify the desired width
                        child: TextField(
                          controller: _passwordController,
                          decoration: const InputDecoration(
                            labelText: 'Password',
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
                      const SizedBox(height: 16.0),
                      ElevatedButton.icon(
                        onPressed: () async {
                          // String email = _emailController.text.trim();
                          // String password = _passwordController.text.trim();

                          // try {
                          //   UserCredential userCredential =
                          //       await _auth.signInWithEmailAndPassword(
                          //     email: email,
                          //     password: password,
                          //   );

                          //   print('User logged in: ${userCredential.user!.uid}');
                          // } catch (e) {
                          //   print('Login failed: $e');
                          // }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                        ),
                        icon: Icon(
                          Icons.login,
                          color: c8,
                        ),
                        label: Text(
                          'Login',
                          style: TextStyle(color: c8),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      // Row containing custom widgets for Login with Google and Login Later
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Custom widget for Iniciar sesión con Google
                          InkWell(
                            onTap: () async {
                              try {
                                final data = await signInWithGoogle();

                                // ignore: use_build_context_synchronously
                                context.read<LoggedUser>().setData(data.user);
                                if (mounted) {
                                  Navigator.pushNamed(
                                      context, routeAgreementLocation);
                                }
                              } on Exception catch (e) {
                                throw Exception(e);
                              }
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 25,
                                  child: SvgPicture.asset(
                                    "assets/images/icons8-logo-de-google.svg",
                                    height: 30,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                const Text(
                                  'Ingresar \ncon Google',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              Navigator.pushNamed(context, routeRegister);
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 25,
                                  child: Icon(
                                    Icons.person_add,
                                    color: c8,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                const Text(
                                  'Registro \nusuario',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, routeAgreementLocation);
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 25,
                                  child: Icon(
                                    Icons.directions_walk_outlined,
                                    color: c8,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                const Text(
                                  'Iniciar \nsesión luego',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
