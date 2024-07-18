import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';


class AuthService{
  final BuildContext context;

  AuthService({required this.context});

  //Google  Sign In
  Future<UserCredential?> signInWithGoogle() async {
    //Show a loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    
    try {
      // Begin interactive sign-in process
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

      // If the user cancels the sign-in process, gUser will be null
      if (gUser == null) {
        // Optionally, handle the case where the user cancels the sign-in process
        return null;
      }

      // Obtain auth details from the request
      final GoogleSignInAuthentication gAuth = await gUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );
      //Pop out the loading circle
      Navigator.pop(context);

      // Then sign in
      return await FirebaseAuth.instance.signInWithCredential(credential);
      
    } catch (e) {
      // Optionally, handle any errors that occur during sign-in
      print("Error signing in with Google: $e");
      //Pop out the loading circle
      Navigator.pop(context);
      return null;
      
    }
  }

}