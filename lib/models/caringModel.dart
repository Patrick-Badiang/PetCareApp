import 'package:flutter/material.dart';

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
        color: Color(0xffD9D9D9),
      ),
      child: Row(
        children: [
          Container(
            alignment: Alignment.center,
            height: 50,
            width: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: isVet ? Color(0xffCA7676) : Color(0xffCAA376),
            ),
          ),
          SizedBox(width: 10),
          Text(name),
          Spacer(),
          Container(
            child: IconButton(
              onPressed: () => onDelete?.call(context),
              icon: Icon(Icons.delete),
            ),
          ),
        ],
      ),
    );
  }
}