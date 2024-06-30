import 'package:flutter/material.dart';

class AppointmentModel extends StatelessWidget {
  final String name;

  const AppointmentModel({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      width: 350.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xffF7FEF2),
      ),
      child: Row(
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color(0xffCA7676),
            ),
            child: Image.asset("assets/images/needle.png"),
          ),
          SizedBox(width: 10),
          Text(name),
        ],
      ),
    );
  }
}
