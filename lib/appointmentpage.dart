import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
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
  //Text Controller
  final _controller = TextEditingController();

  List appointments = [
    ["assets/images/needle.png", "Rabies Shot TBD", Color(0xffCA7676)],
    ["assets/images/dog.png", "Nail Clippings", Color(0xffCAA376)],
    ["assets/images/needle.png", "Rabies Shot TBD", Color(0xffCA7676)],
  ];

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
      if (_appointment == type.vaccine){
        appointments.add(["assets/images/needle.png", _controller.text, Color(0xffCA7676)]);
          } else {
        appointments.add(["assets/images/dog.png", _controller.text, Color(0xffCAA376)]);
    }
      
    });
    
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.add_event ,
        children: [
          SpeedDialChild(
            child: Image.asset("assets/images/needle.png"),
            label: "Vaccine Appointment",
            backgroundColor: Color(0xffCA7676),
            onTap: () {
              _addAppointment(type.vaccine);
            }
          ),
          SpeedDialChild(
            child: Image.asset("assets/images/dog.png"),
            label: "Grooming Appointment",
            backgroundColor: Color(0xffCAA376),
            onTap: () {
              _addAppointment(type.grooming);
            }
          ),
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
              itemCount: appointments.length,
              itemBuilder: (context, index) {
                return AppointmentModel(
                  path: appointments[index][0],
                  name: appointments[index][1],
                  bgcolor: appointments[index][2],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
