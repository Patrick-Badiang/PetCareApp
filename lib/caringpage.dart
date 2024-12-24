import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'package:petcent/models/caringModel.dart';
import 'package:petcent/components/topWidget.dart';
import 'package:petcent/utils/dialog_box.dart';

enum Type { vet, likes }

class CaringPage extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final user;
  const CaringPage({
    super.key,
    required this.user,
  });

  @override
  State<CaringPage> createState() => _CaringPageState();
}

class _CaringPageState extends State<CaringPage> {


  FirebaseFirestore db = FirebaseFirestore.instance;

  //Text Controller
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() async {
    //if  it's first time, and  no  init data
    
  }

  void _addVet(Type add) {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          hint: "Enter ${add == Type.vet ? "Vet" : "Like"} Item",
          controller: _controller,
          onAdd: () => saveNewAdd(add),
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void saveNewAdd(Type add) {
    

    Navigator.of(context).pop();

    if (add == Type.vet) {
      db.collection("vets").doc().set(
        <String, dynamic>{
          "name": _controller.text,
          "isVet": true,
          "owner": widget.user.uid,
        },
      ).onError((e, _) => print("Error writing document: $e"));
    } else {
      db.collection("likes").doc().set(
        <String, dynamic>{
          "name": _controller.text,
          "isVet": false,
          "owner": widget.user.uid,
        },
      ).onError((e, _) => print("Error writing document: $e"));
    }

    _controller.clear();
  }

  void onDelete(Type add, String doc) {
    if (add == Type.vet) {
      db.collection("vets").doc(doc).delete().onError((e, _) => print("Error deleting document: $e"));
    } else {
      db.collection("likes").doc(doc).delete().onError((e, _) => print("Error deleting document: $e"));
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.add_event,
          children: [
            SpeedDialChild(
                labelBackgroundColor: const Color(0xffCAA376),
                label: "Likes",
                onTap: () {
                  _addVet(Type.likes);
                }),
            SpeedDialChild(
                labelBackgroundColor: const Color(0xffCA7676),
                label: "Vet",
                onTap: () {
                  _addVet(Type.vet);
                }),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const TopWidget(subText: "", title: "Things to Know: "),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Text("For the vet I need: "),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: StreamBuilder(
                stream: db.collection("vets").where("owner", isEqualTo: widget.user.uid).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const Text("Loading");
                  return ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return CaringModel(
                        document: snapshot.data!.docs[index],
                        onDelete: (context) => onDelete(Type.vet, snapshot.data!.docs[index].reference.id),
                      );
                    },
                  );
                }
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Text("I like:"),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: StreamBuilder(
                    stream: db
                        .collection("likes")
                        .where("owner", isEqualTo: widget.user.uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if(!snapshot.hasData) return const Text("Loading");

                      return ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return CaringModel(
                            document: snapshot.data!.docs[index],
                            onDelete: (context) => onDelete(Type.likes, snapshot.data!.docs[index].reference.id),
                          );
                        },
                      );
                    })),
          ],
        ));
  }
}
