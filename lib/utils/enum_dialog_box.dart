import 'package:flutter/material.dart';
import 'package:pet_care_app/utils/my_button.dart';

class EnumDialogBox extends StatelessWidget {
  final controller;
  VoidCallback onAdd;
  VoidCallback onCancel;

  EnumDialogBox({
    super.key,
    required this.controller,
    required this.onAdd,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.green,
      content: Container(
          height: 150,
          child: Column(
            children: [
              //Get User input
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Add a new Appointment",
                ),
              ),
              const Spacer(),
              //Add Button and a Cancel Buttons
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
