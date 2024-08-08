import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_care_app/login_register_page.dart';
import 'package:pet_care_app/main.dart';
import 'package:pet_care_app/new_user_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        //if user is logged in  or out
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            User? user = FirebaseAuth.instance.currentUser;

      if (user == null){
        return const Text("Login failed");
      }
      user.reload();
      var metadata = user.metadata;
      if (metadata.creationTime == metadata.lastSignInTime) {
        // The user is new, show them a fancy intro screen!
        return const NewUser();
      } else {
        // This is an existing user, show them a welcome back screen.
        return const MyHomePage(); 
      }
    
          } else {
            //if user is logged out
            return const LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}
