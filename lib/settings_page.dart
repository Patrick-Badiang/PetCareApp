
//Settings page that will be displayed when the settings button is clicked
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  final User user;
  const SettingsPage({super.key, required this.user});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
    FirebaseFirestore db = FirebaseFirestore.instance;
  late Stream<QuerySnapshot> reference;
  late bool isEditing;

  late TextEditingController petNameController;
  late TextEditingController vetNameController;
  late TextEditingController vetNumberController;
  late TextEditingController vetLocationController;


  @override
  void initState() {
    super.initState();
    isEditing = false;
    reference = db.collection("pets").where("owner", isEqualTo: widget.user.uid).snapshots();
    // reference = db.collection("pets").doc(widget.user.uid);
    petNameController = TextEditingController();
    vetNameController = TextEditingController();
    vetNumberController = TextEditingController();
    vetLocationController = TextEditingController();
  }
  
  void toggleEditing() async {

    if (isEditing) {
      // Save changes to Firestore
      try {
        final document = (await reference.first).docs.first;
        await document.reference.update({
          'name': petNameController.text,
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: const Color(0xff4F759B),
      ),
      body: Column(
        children: <Widget>[
          Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Text(
                      'Edit Information',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  IconButton(
                    icon: Icon(isEditing ? Icons.check : Icons.edit),
                    onPressed: toggleEditing,
                  ),
                ],
              ),
          StreamBuilder<QuerySnapshot>(
            stream: db.collection("pets").where("owner", isEqualTo: widget.user.uid).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text('Loading...');
              }

              // Assuming only one pet per user
              final document = snapshot.data!.docs.first;
              final petData = document.data() as Map<String, dynamic>;
              final petName = petData['name']; // Replace 'name' with the actual field name if different
              final vetName = petData['vetName'] ?? 'N/A';
              final vetNumber = petData['vetNumber'] ?? 'N/A';
              final vetLocation = petData['vetLocation'] ?? 'N/A';

              petNameController.text = petName;
              vetNameController.text = vetName;
              vetNumberController.text = vetNumber;
              vetLocationController.text = vetLocation;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAttributeRow("Pet Name:", petNameController),
                  _buildAttributeRow("Vet Name:", vetNameController),
                  _buildAttributeRow("Vet Number:", vetNumberController),
                  _buildAttributeRow("Vet Location:", vetLocationController),
                ],
              );
            },
          ),
          
          
          Center(
            child: Row(children: [
              const Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  'Sign Out',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                },
              ),
            ],),
          ),
        ],
      ),
    );
  }

  Widget _buildAttributeRow(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 20),
          ),
          Expanded(
            child: isEditing
                ? TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.only(right: 5),
                    ),
                    style: const TextStyle(fontSize: 20),
                  )
                : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                      controller.text,
                      style: const TextStyle(fontSize: 20),
                    ),
                ),
          ),
        ],
      ),
    );
  }
}
