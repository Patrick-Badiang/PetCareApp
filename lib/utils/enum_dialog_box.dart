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
          height: 200,
          child: Column(
            children: [
              //Get User input
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Add a new Appointment",
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
