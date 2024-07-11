import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:pet_care_app/homepage.dart';
import 'package:pet_care_app/login_page.dart';
import 'package:pet_care_app/main.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(

        //if user is logged in  or out
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   print("Waiting");
          //   return const Center(
          //     child: CircularProgressIndicator(),
          //   );
          // } else if (snapshot.hasError) {
          //   return const Center(
          //     child: Text('An error occurred'),
          //   );
          // } else 
          if (snapshot.hasData) {
            //if user is logged in
            return const MyHomePage();
          } else {
            //if user is logged out
            return const LoginPage();
          }
        },
      ),
    );
  }
}