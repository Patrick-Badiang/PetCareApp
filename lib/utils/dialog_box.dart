import 'package:flutter/material.dart';
import 'package:petcent/utils/my_button.dart';

// ignore: must_be_immutable
class DialogBox extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  final String hint;
  VoidCallback onAdd;
  VoidCallback onCancel;


  DialogBox({
    super.key,
    required this.controller,
    required this.hint,
    required  this.onAdd,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.green,
      content: SizedBox(
          height: 150,
          child: Column(
            children: [
              //Get User input
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: hint,
                ),
              ),

              //Add Button and a Cancel Button
              Row(
                children: [
                  MyButton(text: "Add", onPressed: onAdd),
                  const Spacer(),
                  MyButton(text: "Cancel", onPressed: onCancel),
                ],
              )
            ],
          )),
    );
  }
}
