
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_care_app/models/appointmentModel.dart';
import 'package:pet_care_app/topWidget.dart';

class Appointments extends StatelessWidget {
  const Appointments({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
        children: <Widget>[
          TopWidget(subText: "", title: "My Appointments:"),
          SizedBox(height: 20,),
          AppointmentModel(name: "Rabies Shot TBD"),
        ],
      
    );
  }
}
