import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pet_care_app/data/database.dart';
import 'package:pet_care_app/models/appointmentModel.dart';
import 'package:pet_care_app/topWidget.dart';

import 'package:pet_care_app/utils/enum_dialog_box.dart';

enum type {
  vaccine,
  grooming,
}

class Appointments extends StatefulWidget {
  Appointments({super.key});

  @override
  State<Appointments> createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  //reference hive box
  final _appBox = Hive.box('appointments');
  AppointmentDatabase apps = AppointmentDatabase();

  //Text Controller
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() async {
        //if  it's first time, and  no  init data

    if (_appBox.get("APPOINTMENTS") == null) {
      apps.createInitialData();
    } else {
      apps.loadData();
    }

  }

  void _addAppointment(type appointment) {
    showDialog(
      context: context,
      builder: (context) {
        return EnumDialogBox(
          controller: _controller,
          onAdd: () => saveNewAppointment(appointment),
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void saveNewAppointment(type _appointment) {
    setState(() {
      if (_appointment == type.vaccine) {
        apps.appointments.add(
            ["assets/images/needle.png", _controller.text, Color(0xffCA7676)]);
      } else {
        apps.appointments.add(
            ["assets/images/dog.png", _controller.text, Color(0xffCAA376)]);
      }
    });

    Navigator.of(context).pop();
  }

  void deleteTask(int index){
    setState(() {
      apps.appointments.removeAt(index);
    });
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
              backgroundColor: Color(0xffCA7676),
              onTap: () {
                _addAppointment(type.vaccine);
              }),
          SpeedDialChild(
              child: Image.asset("assets/images/dog.png"),
              label: "Grooming Appointment",
              backgroundColor: Color(0xffCAA376),
              onTap: () {
                _addAppointment(type.grooming);
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
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              separatorBuilder: (context, index) => SizedBox(height: 10),
              itemCount: apps.appointments.length,
              itemBuilder: (context, index) {
                return AppointmentModel(
                  path: apps.appointments[index][0],
                  name: apps.appointments[index][1],
                  bgcolor: apps.appointments[index][2],
                  onDelete: (context) => deleteTask(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
