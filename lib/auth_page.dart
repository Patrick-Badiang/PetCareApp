import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key})
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(

        //if user is logged in  or out
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            print("Waiting");
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('An error occurred'),
            );
          } else if (snapshot.hasData) {
            print(snapshot.data);
            //if user is logged in
            return const HomePage();
          } else {
            print("Not logged in");
            //if user is logged out
            return const LoginPage();
          }
        },
      ),
    );
  }
}