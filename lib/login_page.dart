import 'package:flutter/material.dart';
import 'package:pet_care_app/main.dart';
import 'package:pet_care_app/utils/my_sign_in_button.dart';
import 'package:pet_care_app/utils/my_square_tile.dart';
import 'package:pet_care_app/utils/styled_text_field.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn() async {
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
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text
            .trim(), // Trim to remove any leading/trailing whitespace
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        // Handle the invalid credential error
        print('The supplied auth credential is malformed or has expired.');
        // Optionally, show an error message to the user
      } else {
        // Handle other FirebaseAuthExceptions
        print('An error occurred: ${e.message}');
      }
    } catch (e) {
      // Handle any other exceptions
      print('An unexpected error occurred: $e');
    }

    //Pop out the loading circle
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE5E5E5),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Login  Icon
              const SizedBox(height: 25),
              Image.asset("assets/images/Login/LoginPhoto.png"),

              //Welcome back text
              const SizedBox(height: 50),
              const Text(
                "Welcome Back",
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),

              //Email and Password TextFields
              const SizedBox(height: 25),
              StyledTextField(
                controller: emailController,
                hintText: 'Enter your Email',
                obscureText: false,
              ),
              const SizedBox(
                height: 15,
              ),
              StyledTextField(
                controller: passwordController,
                hintText: 'Enter your Password',
                obscureText: true,
              ),

              //Forgot password?
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 25.0),
                    child: Text("Forgot Password?"),
                  )
                ],
              ),

              //Sign in  Button
              const SizedBox(
                height: 25,
              ),
              MySignInButton(
                onTap: signUserIn,
              ),

              //Continue with
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: Colors.grey[400],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Text("Or Continue With"),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),

              //Google and Facebook Icons
              const SizedBox(
                height: 25,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareTile(imagePath: "assets/images/Login/GoogleIcon.png"),
                    SizedBox(width: 20),
                    SquareTile(imagePath: "assets/images/Login/AppleIcon.png"),
                  ],
                ),
              ),

              //Not a member? Register now
              const SizedBox(
                height: 25,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Not a member?"),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Register now",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
              // ListView
            ],
          ),
        ),
      ),
    );
  }
}
