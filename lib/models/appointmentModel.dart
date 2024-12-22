// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppointmentModel extends StatelessWidget {
  final DocumentSnapshot document;
  
  Function(BuildContext?)? onDelete;

  AppointmentModel({
    super.key,
    required this.document,
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
              color: document['isVet'] ? const Color(0xffCAA376) : const Color(0xffCA7676),
            ),
            child: Image.asset(document['image']),
          ),
          const SizedBox(width: 10),
          Text(document['name']),
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
