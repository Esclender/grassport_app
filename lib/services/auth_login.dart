import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:grassport_app/api/api_client.dart';
import 'package:grassport_app/models/logged_user.dart';
import 'package:grassport_app/presentation/bloc/isAdmin/bloc.dart';
import 'package:grassport_app/presentation/bloc/loged_user_data/bloc.dart';
import 'package:grassport_app/services/save_preferens.dart';
import 'package:grassport_app/services/session_manager.dart';

Future<UserDisplayed> signInWithGoogle(BuildContext context) async {
  bool isConnectedWithNoPreviousToken = await GoogleSignIn().isSignedIn();

  if (isConnectedWithNoPreviousToken) {
    await GoogleSignIn().disconnect();
  }

  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  final auth = FirebaseAuth.instance;
  UserCredential userInfo = await auth.signInWithCredential(credential);

  String jwtToken = await ApiClient().getToken(
    email: userInfo.user?.email ?? '',
  );

  bool isAdmin = SessionManager.extractIsAdmin(jwtToken);
  String name = SessionManager.extractNombre(jwtToken);
  String photoUrl = SessionManager.extractPhotoURL(jwtToken);

  UserDisplayed userData = UserDisplayed(
    displayName: name,
    photoURL: photoUrl,
    isAdmin: isAdmin,
  );

  if (isAdmin) {
    userData.account = "admin";
  }

  // ignore: use_build_context_synchronously
  context.read<LoggedUser>().setData(userData);

  // Once signed in, return the UserCredential
  return userData;
}

Future<void> logOutWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignIn googleUser = GoogleSignIn();
  await Cookies().save(key: 'userToken', value: '');
  await googleUser.signOut();
}

Future<bool> checkIfUserIsSignedInJWT(BuildContext context) async {
  String jwtToken = await Cookies().load(key: 'userToken');

  if (SessionManager.isTokenExpired(jwtToken)) {
    return false;
  }

  bool isAdmin = SessionManager.extractIsAdmin(jwtToken);
  String nombre = SessionManager.extractNombre(jwtToken);
  String photoURL = SessionManager.extractPhotoURL(jwtToken);

  UserDisplayed userData = UserDisplayed(
    displayName: nombre,
    photoURL: photoURL,
  );

  // ignore: use_build_context_synchronously
  context.read<LoggedUser>().setData(userData);
  // ignore: use_build_context_synchronously
  context.read<IsAdmin>().setIsAdmin(isAdmin);

  return true;
}

Future registerUser({
  String? email,
  String? password,
  String? nombre,
  String? apellido,
  String? numero,
  required File image,
}) async {
  try {
    Map confirmationData = await ApiClient().registerUser(
      image: image,
      email: email as String,
      nombre: nombre as String,
      apellido: apellido as String,
      numero: numero as String,
      clave: password as String,
    );

    return confirmationData;
  } catch (e) {
    print('Error registering user: $e');
  }
}

Future<bool> loginWithCredentials({
  String? email,
  String? password,
  BuildContext? context,
}) async {
  final data = await ApiClient().login(
    email: email,
    clave: password,
  );

  bool isAdmin = SessionManager.extractIsAdmin(data);
  String nombre = SessionManager.extractNombre(data);
  String photoURL = SessionManager.extractPhotoURL(data);

  UserDisplayed userData = UserDisplayed(
    displayName: nombre,
    photoURL: photoURL,
  );

  context?.read<LoggedUser>().setData(userData);
  context?.read<IsAdmin>().setIsAdmin(isAdmin);

  return isAdmin;
}
