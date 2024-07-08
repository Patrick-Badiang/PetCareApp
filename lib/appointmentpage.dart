import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pet_care_app/data/database.dart';
import 'package:pet_care_app/models/appointmentModel.dart';
import 'package:pet_care_app/topWidget.dart';
import 'package:pet_care_app/utils/dialog_box.dart';


enum Type {
  vaccine,
  grooming,
}

class Appointments extends StatefulWidget {
  const Appointments({super.key});

  @override
  State<Appointments> createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  //reference hive box
  final _appBox = Hive.box('mybox');
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
    setState(() {
      if (appointment == Type.vaccine) {
        apps.appointments.add(
            ["assets/images/needle.png", _controller.text, true]);
      } else {
        apps.appointments.add(
            ["assets/images/dog.png", _controller.text, false]);
      }
    });

    Navigator.of(context).pop();
    apps.updateDataBase();

  }

  void deleteTask(int index){
    setState(() {
      apps.appointments.removeAt(index);
    });
    apps.updateDataBase();

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
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemCount: apps.appointments.length,
              itemBuilder: (context, index) {
                return AppointmentModel(
                  path: apps.appointments[index][0],
                  name: apps.appointments[index][1],
                  isVet: apps.appointments[index][2],
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
