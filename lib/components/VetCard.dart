import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:petcent/models/taskModel.dart';
import 'package:petcent/components/topWidget.dart';
import 'package:petcent/utils/dialog_box.dart';

import 'package:cloud_firestore/cloud_firestore.dart';


class VetCard extends StatefulWidget {
  final String vetName;
  final String vetNumber;
  final String vetLocation;
  final DocumentSnapshot document;

  const VetCard({
    Key? key,
    required this.vetName,
    required this.vetNumber,
    required this.vetLocation,
    required this.document,
  }) : super(key: key);

  @override
  _VetCardState createState() => _VetCardState();
}

class _VetCardState extends State<VetCard> {
  late bool isEditing;
  late TextEditingController vetNameController;
  late TextEditingController vetNumberController;
  late TextEditingController vetLocationController;

  @override
  void initState() {
    super.initState();
    isEditing = false;
    vetNameController = TextEditingController(text: widget.vetName);
    vetNumberController = TextEditingController(text: widget.vetNumber);
    vetLocationController = TextEditingController(text: widget.vetLocation);
  }

  void toggleEditing() async {
    if (isEditing) {
      // Save changes to Firestore
      try {
        await widget.document.reference.update({
          'vetName': vetNameController.text,
          'vetNumber': vetNumberController.text,
          'vetLocation': vetLocationController.text,
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Changes saved successfully!')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save changes: $e')),
        );
      }
    }

    setState(() {
      isEditing = !isEditing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300,
        decoration: BoxDecoration(
          color: const Color.fromARGB(217, 217, 217, 217),
          borderRadius: BorderRadius.circular(15),
        ),
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
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  IconButton(
                    icon: Icon(isEditing ? Icons.check : Icons.edit),
                    onPressed: toggleEditing,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            _buildAttributeRow('Name:', vetNameController),
            const SizedBox(height: 10),
            _buildAttributeRow('Number:', vetNumberController),
            const SizedBox(height: 10),
            _buildAttributeRow('Location:', vetLocationController),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildAttributeRow(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 10),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: isEditing
                ? TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 5),
                    ),
                    style: const TextStyle(fontSize: 15),
                  )
                : Text(
                    controller.text,
                    style: const TextStyle(fontSize: 15),
                  ),
          ),
        ],
      ),
    );
  }
}
