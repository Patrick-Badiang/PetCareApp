import 'package:flutter/material.dart';

class AppointmentModel extends StatelessWidget {
  final String path;
  final String name;
  final Color  bgcolor;

  const AppointmentModel({
    super.key,
    required this.name,
    required this.path,
    required this.bgcolor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xffD9D9D9),
      ),
      child: Row(
        children: [
          Container(
            alignment: Alignment.center,
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: bgcolor,
            ),
            child: Image.asset(path),
          ),
          SizedBox(width: 10),
          Text(name),
        ],
      ),
    );
  }
}
