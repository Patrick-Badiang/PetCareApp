import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petcent/login_register_page.dart';
import 'package:petcent/main.dart';
import 'package:petcent/new_user_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          if (user != null) {
            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .doc(user.uid)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  final userDoc = snapshot.data;
                  if (userDoc?.exists ?? false) {
                    final isNewUser = userDoc!['isNewUser'] as bool;
                    return isNewUser ? NewUser(user: user) : MyHomePage();
                  } else {
                    // Create a new user document with isNewUser set to true
                    FirebaseFirestore.instance
                        .collection('users')
                        .doc(user.uid)
                        .set({'isNewUser': true});
                    return NewUser(user: user);
                  }
                } else {
                  return const CircularProgressIndicator();
                }
              },
            );
          } else {
            return LoginOrRegisterPage(); // Or your login page
          }
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
