import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';


import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:petcent/auth_page.dart';
import 'package:petcent/login_register_page.dart';
import 'package:petcent/main.dart';
import 'package:petcent/utils/my_sign_in_button.dart';
import 'package:petcent/utils/styled_text_field.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'dart:typed_data';



class NewUser extends StatefulWidget {
  final user;
  const NewUser({super.key, required this.user});

  @override
  State<NewUser> createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> {
  final nameController = TextEditingController();
  final  vetNameController = TextEditingController();
  final vetLocationController = TextEditingController();
  final vetPhoneController = TextEditingController(); 

  File? _selectedImage;
  Uint8List? _selectedImageBytes; // Store image data for web

  final ImagePicker _picker = ImagePicker();
final FirebaseStorage _storage = FirebaseStorage.instanceFor(bucket: "gs://petcareapp-c0a3f.appspot.com/");

  void addPetName(BuildContext context, String name, String ownerUid, String profilePath) async {
    try {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false, // Prevent dismissing by tapping outside
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      /*
      final petName = petData['name']; // Replace 'name' with the actual field name if different
                final vetName = petData['vetName'] ?? 'N/A';
                final vetNumber = petData['vetNumber'] ?? 'N/A';
                final vetLocation = petData['vetLocation'] ?? 'N/A';
      */

      // Add pet name to Firestore
      await FirebaseFirestore.instance.collection("pets").add({
        "name": name,
        "owner": ownerUid,
        "profilePic": profilePath,
        "vetNumber": vetPhoneController.text,
        "vetLocation": vetLocationController.text,
        "vetName": vetNameController.text,
      });

      // Dismiss loading indicator
      Navigator.pop(context);

      // Update isNewUser to false
      await FirebaseFirestore.instance
          .collection('users')
          .doc(ownerUid)
          .update({'isNewUser': false});

      // Show success message or navigate to another page
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pet added successfully!')),
      );

      // You can replace this with your desired navigation logic
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AuthPage()),
      );
    } catch (e) {
      // Handle errors
      print('Error adding pet: $e');
      // Dismiss loading indicator
      Navigator.pop(context);
      // Show error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error adding pet. Please try again.')),
      );
    }
  }


Future<void> _pickImage() async {
  try {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (image != null) {
      final Uint8List imageBytes = await image.readAsBytes(); // Read file as bytes
      setState(() {
        _selectedImageBytes = imageBytes;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Image selected!')),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error selecting image: $e')),
    );
  }
}


  // Function to upload the selected image to Firebase Storage
  Future<String> uploadImage(String path, XFile image) async {
    try {
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;

    } on FirebaseException catch (e) {
      print('Error uploading image: $e');
    } catch (e) {
      print('Error uploading image: $e');
    }
    return ''; // Return an empty string or handle the error appropriately
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE5E5E5),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Go back button
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      // Navigator.pushReplacement(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => const LoginOrRegisterPage()),
                      // );
                    },
                  ),
                ],
              ),
              //Login  Icon
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 50,
                      child: Image.asset("assets/images/PetCentLogo.png")),
                  const Text("Pet Cent", style: TextStyle(fontSize: 30)),
                ],
              ),

              //Welcome back text
              const SizedBox(height: 20),
              const Text(
                "Let's get you setup",
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),

              //Email and Password TextFields
              const SizedBox(height: 25),
              const Text("About your pet"),
              StyledTextField(
                controller: nameController,
                hintText: 'Enter your pet\'s name',
                obscureText: false,
              ),

              //Veterinarian Name
              const SizedBox(height: 20),
              const Text("About your veterinarian"),

              StyledTextField(
                controller: vetNameController,
                hintText: 'Enter your veterinarian\'s name',
                obscureText: false,
              ),
              //Veterinarian Location
              const SizedBox(height: 20),
              StyledTextField(
                controller: vetLocationController,
                hintText: 'Enter your veterinarian\'s location',
                obscureText: false,
              ),
              //Veterinarian Phone Number
              const SizedBox(height: 20),
              StyledTextField(
                controller: vetPhoneController,
                hintText: 'Enter your veterinarian\'s phone number',
                obscureText: false,
              ),

              // Center(
              //         child: Column(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             if (_selectedImage != null)
              //               Image.file(
              //                 _selectedImage!,
              //                 height: 200,
              //               ),
              //             const SizedBox(height: 20),
              //             ElevatedButton(
              //               onPressed: _pickImage,
              //               child: const Text('Upload Image'),
              //             ),
              //             const SizedBox(height: 10),
              //             ElevatedButton(
              //               onPressed: _uploadImage,
              //               child: const Text('Upload to Firebase'),
              //             ),
              //           ],
              //         ),
              //       ),
              // //Upload Image
              // const SizedBox(height: 20),
              // const Text("Upload an image of your pet"),
              // const SizedBox(height: 20),
              // ElevatedButton(
              //   onPressed: () {},
              //   child: const Text("Upload Image"),
              // ),


              //Continue  Button
              const Spacer(),
              MySignInButton(
                text: "Continue",
                onTap: () =>
                    addPetName(context, nameController.text, widget.user.uid, "Test"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
