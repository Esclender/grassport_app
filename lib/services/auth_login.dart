import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:grassport_app/presentation/bloc/loged_user_data/bloc.dart';

Future<UserCredential> signInWithGoogle() async {
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

  // Once signed in, return the UserCredential
  return await auth.signInWithCredential(credential);
}

Future<void> logOutWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignIn googleUser = GoogleSignIn();
  await googleUser.signOut();
}

Future<bool> checkIfUserIsSignedIn(BuildContext context) async {
  GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);

  bool isSignedIn = await googleSignIn.isSignedIn();

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

    // ignore: use_build_context_synchronously
    context.read<LoggedUser>().setData(authCredencials.user);
    return true;
  }

  return false;
}
