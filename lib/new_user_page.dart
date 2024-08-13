import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pet_care_app/auth_page.dart';
import 'package:pet_care_app/login_register_page.dart';
import 'package:pet_care_app/main.dart';
import 'package:pet_care_app/utils/my_sign_in_button.dart';
import 'package:pet_care_app/utils/styled_text_field.dart';

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

  void addPetName(BuildContext context, String name, String ownerUid) async {
    try {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false, // Prevent dismissing by tapping outside
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      // Add pet name to Firestore
      await FirebaseFirestore.instance.collection("pets").add({
        "name": name,
        "owner": ownerUid,
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
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginOrRegisterPage()),
                      );
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

              //Upload Image
              const SizedBox(height: 20),
              const Text("Upload an image of your pet"),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                child: const Text("Upload Image"),
              ),


              //Continue  Button
              const Spacer(),
              MySignInButton(
                text: "Continue",
                onTap: () =>
                    addPetName(context, nameController.text, widget.user.uid),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
