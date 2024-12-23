import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:petcent/models/taskModel.dart';
import 'package:petcent/topWidget.dart';
import 'package:petcent/utils/dialog_box.dart';

import 'package:cloud_firestore/cloud_firestore.dart';


class VetCard extends StatelessWidget {
  final String vetName;
  final String vetNumber;
  final String vetLocation;

  const VetCard({
    Key? key,
    required this.vetName,
    required this.vetNumber,
    required this.vetLocation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300,
        decoration: BoxDecoration(
            color: const Color.fromARGB(217, 217, 217, 217),
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 10),
            Center(
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Text(
                      'Veterinarian Information',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {}, // Implement edit logic if needed
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  const Text(
                    'Name:',
                    style: TextStyle(fontSize: 10),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: Text(
                      vetName,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  const Text(
                    'Number:',
                    style: TextStyle(fontSize: 10),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      vetNumber,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  const Text(
                    'Location:',
                    style: TextStyle(fontSize: 10),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      vetLocation,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
