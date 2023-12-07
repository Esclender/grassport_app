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

Future<UserDisplayed> signInWithGoogle() async {
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

  String jwtToken =
      await ApiClient().getToken(email: userInfo.user?.email ?? '');

  bool isAdmin = SessionManager.extractIsAdmin(jwtToken);

  UserDisplayed userData = UserDisplayed(
      displayName: userInfo.user?.displayName,
      photoURL: userInfo.user?.photoURL,
      isAdmin: isAdmin);

  // Once signed in, return the UserCredential
  return userData;
}

Future<void> logOutWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignIn googleUser = GoogleSignIn();
  await Cookies().save(key: 'userToken', value: '');
  await googleUser.signOut();
}

Future<bool> checkIfUserIsSignedIn(BuildContext context) async {
  GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);

  bool isSignedIn = await googleSignIn.isSignedIn();

  print('********************************************************isLoggedUser');
  print(isSignedIn);

  if (isSignedIn) {
    try {
      await googleSignIn.signInSilently();
    } catch (error) {
      print('Error signing in silently: $error');
    }

    GoogleSignInAccount? googleUser = googleSignIn.currentUser;

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final auth = FirebaseAuth.instance;

    final authCredencials = await auth.signInWithCredential(credential);

    UserDisplayed userData = UserDisplayed(
      displayName: authCredencials.user?.displayName,
      photoURL: authCredencials.user?.photoURL,
    );

    String jwtToken =
        await ApiClient().getToken(email: authCredencials.user?.email ?? '');
    bool isAdmin = SessionManager.extractIsAdmin(jwtToken);

    // ignore: use_build_context_synchronously
    context.read<LoggedUser>().setData(userData);
    // ignore: use_build_context_synchronously
    context.read<IsAdmin>().setIsAdmin(isAdmin);
    return true;
  }

  return false;
}

Future<bool> checkIfUserIsSignedInJWT(BuildContext context) async {
  bool isGoogleSigned = await checkIfUserIsSignedIn(context);

  if (!isGoogleSigned) {
    String jwtToken = await Cookies().load(key: 'userToken');

    // Check if the JWT token is expired
    if (SessionManager.isTokenExpired(jwtToken)) {
      return false; // Token is expired
    }

    bool isAdmin = SessionManager.extractIsAdmin(jwtToken);
    String nombre = SessionManager.extractNombre(jwtToken);

    UserDisplayed userData = UserDisplayed(
      displayName: nombre,
    );

    // ignore: use_build_context_synchronously
    context.read<LoggedUser>().setData(userData);
    // ignore: use_build_context_synchronously
    context.read<IsAdmin>().setIsAdmin(isAdmin);

    return true;
  }

  return false;
}

Future<void> registerUser({
  String? email,
  String? password,
  String? nombre,
  String? apellido,
  String? numero,
}) async {
  try {
    Map datosUser = {
      'email': email,
      'clave': password,
      'nombre': nombre,
      'apellido': apellido,
      'numero': numero
    };

    await ApiClient().registerUser(datosUser);
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

  UserDisplayed userData = UserDisplayed(
    displayName: nombre,
  );

  context?.read<LoggedUser>().setData(userData);
  context?.read<IsAdmin>().setIsAdmin(isAdmin);

  return isAdmin;
}
