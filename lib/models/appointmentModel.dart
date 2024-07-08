// ignore: file_names
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppointmentModel extends StatelessWidget {
  final String path;
  final String name;
  final bool isVet;
  Function(BuildContext?)? onDelete;

  AppointmentModel({
    super.key,
    required this.name,
    required this.path,
    required this.isVet,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xffD9D9D9),
      ),
      child: Row(
        children: [
          Container(
            alignment: Alignment.center,
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: isVet ? const Color(0xffCAA376) : const Color(0xffCA7676),
            ),
            child: Image.asset(path),
          ),
          const SizedBox(width: 10),
          Text(name),
          const Spacer(),
          IconButton(
              onPressed: () => onDelete?.call(context),
              icon: const Icon(Icons.delete),
            ),
          
        ],
      ),
    );
  }
}
