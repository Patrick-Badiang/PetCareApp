// ignore: file_names
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CaringModel extends StatelessWidget {
  final String name;
  final bool isVet;
  Function(BuildContext?)? onDelete;

  CaringModel({
    super.key,
    required this.name,
    required this.isVet,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xffD9D9D9),
      ),
      child: Row(
        children: [
          Container(
            alignment: Alignment.center,
            height: 50,
            width: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: isVet ? const Color(0xffCA7676) : const Color(0xffCAA376),
            ),
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