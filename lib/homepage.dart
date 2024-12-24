// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:petcent/components/VetCard.dart';

import 'package:petcent/models/taskModel.dart';
import 'package:petcent/components/topWidget.dart';
import 'package:petcent/utils/dialog_box.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  final user;
  const HomePage({
    super.key,
    required this.user,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseFirestore db = FirebaseFirestore.instance;

  //Text Controller
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    initApp();
  }

  void initApp() async {
    // If this is the first time opening the app then create default values
  }

  // void _taskClicked(bool? value, DocumentSnapshot index) {

  // }

  void _addTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          hint: "Enter Task Name",
          controller: _controller,
          onAdd: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void saveNewTask() {
    Navigator.of(context).pop();

    db.collection("tasks").doc().set(
      <String, dynamic>{
        "isDone": false,
        "task": _controller.text,
        "owner": widget.user.uid,
      },
    ).onError((e, _) => print("Error writing document: $e"));

    _controller.clear();
  }

  void deleteTask(String doc) {
    db
        .collection("tasks")
        .doc(doc)
        .delete()
        .onError((e, _) => print("Error deleting document: $e"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.small(
        shape: const CircleBorder(),
        backgroundColor: const Color(0xff73BA9B),
        onPressed: () {
          _addTask();
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
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

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TopWidget(
                    subText: "My Name is:",
                    title: petName,
                  ),
                  const SizedBox(height: 20),
                  VetCard(
                    vetName: vetName,
                    vetNumber: vetNumber,
                    vetLocation: vetLocation,
                    document: document, // Pass the Firestore document
                  ),
                ],
              );
            },
          ),


          const SizedBox(height: 30),
          const Padding(
            padding: EdgeInsets.only(left: 30.0),
            child: Text("Daily Tasks"),
          ),
          const SizedBox(height: 15),
          Expanded(
            // Wrap the Container in an Expanded widget
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: StreamBuilder(
                  stream: db
                      .collection('tasks')
                      .where("owner", isEqualTo: widget.user.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return const Text("Loading");

                    return ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.docs.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        return TaskTile(
                          document: snapshot.data!.docs[index],
                          isDone: snapshot.data!.docs[index]['isDone'] as bool,
                          onChanged: (context) => {
                            FirebaseFirestore.instance
                                .runTransaction((transactionHandler) async {
                              DocumentSnapshot freshSnap =
                                  await transactionHandler.get(
                                      snapshot.data!.docs[index].reference);
                              // ignore: await_only_futures
                              await transactionHandler.update(
                                  freshSnap.reference,
                                  {'isDone': !freshSnap['isDone']});
                            })
                          },
                          onDelete: (context) => deleteTask(
                              snapshot.data!.docs[index].reference.id),
                        );
                      },
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}

