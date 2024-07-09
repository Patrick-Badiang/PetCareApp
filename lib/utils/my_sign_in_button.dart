import 'package:flutter/material.dart';

class MySignInButton extends StatelessWidget {

  final Function()? onTap;

  const MySignInButton({
    super.key,
    required  this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 300,
        height: 50,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 61, 61, 61),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: Text(
            "Sign In",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
