import 'package:flutter/material.dart';
import 'package:petcent/services/auth_service.dart';
import 'package:petcent/utils/my_sign_in_button.dart';
import 'package:petcent/utils/my_square_tile.dart';
import 'package:petcent/utils/styled_text_field.dart';

import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;

  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void signUserUp() async {
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
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(), // Trim to remove any leading/trailing whitespace
          password: passwordController.text,
        );
        //Pop out the loading circle
      Navigator.pop(context);
      } else {
        //Pop out the loading circle
      Navigator.pop(context);
        showError('Passwords do not match');
      }

      
    } on FirebaseAuthException catch (e) {
      //Pop out the loading circle
      Navigator.pop(context);
      if (e.code == 'invalid-credential') {
        // Handle the invalid credential error
        showError('Invalid credentials');
        // Optionally, show an error message to the user
      } else {
        // Handle other FirebaseAuthExceptions
        showError('An error occurred: ${e.message}');
      }
    } catch (e) {
      // Handle any other exceptions
      showError('An unexpected error occurred: $e');
    }
  }

  void showError(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE5E5E5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Login  Icon
                const SizedBox(height: 25),
                Image.asset("assets/images/RegisterPhoto.png"),

                //Welcome back text
                const SizedBox(height: 50),
                const Text(
                  "Welcome!",
                  style: TextStyle(fontSize: 30, color: Colors.black),
                ),
                const Text(
                  "Let's get your information right",
                  style: TextStyle(fontSize: 15, color: Colors.black),
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
                const SizedBox(
                  height: 15,
                ),
                StyledTextField(
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),

                //Sign in  Button
                const SizedBox(
                  height: 25,
                ),
                MySignInButton(
                  text: "Sign Up",
                  onTap: signUserUp,
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
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SquareTile(
                        onTap: () => AuthService(context: context).signInWithGoogle(),
                          imagePath: "assets/images/Login/GoogleIcon.png"),
                      const SizedBox(width: 20),
                      SquareTile(
                        onTap: () => AuthService(context: context).signInWithGoogle(),
                          imagePath: "assets/images/Login/AppleIcon.png"),
                    ],
                  ),
                ),

                //Not a member? Register now
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already a member?"),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        "Login now",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
                // ListView
              ],
            ),
          ),
        ),
      ),
    );
  }
}
