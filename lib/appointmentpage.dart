import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:petcent/models/appointmentModel.dart';
import 'package:petcent/components/topWidget.dart';
import 'package:petcent/utils/dialog_box.dart';

enum Type {
  vaccine,
  grooming,
}

class Appointments extends StatefulWidget {
  final user;
  const Appointments({super.key, required this.user});

  @override
  State<Appointments> createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {


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

  void _addAppointment(Type appointment) {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          hint: "Enter Appointment Name",
          controller: _controller,
          onAdd: () => saveNewAppointment(appointment),
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void saveNewAppointment(Type appointment) {
    Navigator.of(context).pop();

    if (appointment == Type.vaccine) {
      db.collection("appointments").doc().set(
        <String, dynamic>{
          "image": "assets/images/needle.png",
          "name": _controller.text,
          "isVet": true,
          "owner": widget.user.uid,
        },
      ).onError((e, _) => print("Error writing document: $e"));
    } else {
      db.collection("appointments").doc().set(
        <String, dynamic>{
          "image": "assets/images/dog.png",
          "name": _controller.text,
          "isVet": false,
          "owner": widget.user.uid,
        },
      ).onError((e, _) => print("Error writing document: $e"));
    }

    _controller.clear();

  }

  void deleteTask(String doc) {
    db.collection("appointments").doc(doc).delete().onError((e, _) => print("Error deleting document: $e"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.add_event,
        children: [
          SpeedDialChild(
              child: Image.asset("assets/images/needle.png"),
              label: "Vaccine Appointment",
              onTap: () {
                _addAppointment(Type.vaccine);
              }),
          SpeedDialChild(
              child: Image.asset("assets/images/dogoutline.png"),
              label: "Grooming Appointment",
              onTap: () {
                _addAppointment(Type.grooming);
              }),
        ],
      ),
      body: Column(
        children: <Widget>[
          const TopWidget(subText: "", title: "My Appointments:"),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: StreamBuilder(
                stream: db
                    .collection("appointments")
                    .where("owner", isEqualTo: widget.user.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const Text("Loading");

                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return AppointmentModel(
                        document: snapshot.data!.docs[index],
                        onDelete: (context) => deleteTask(snapshot.data!.docs[index].reference.id),
                      );
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }
}
