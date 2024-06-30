import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_care_app/models/appointmentModel.dart';
import 'package:pet_care_app/topWidget.dart';

class Appointments extends StatelessWidget {
  Appointments({super.key});

  List appointments = [
    ["assets/images/needle.png", "Rabies Shot TBD", Color(0xffCA7676)],
    ["assets/images/dog.png", "Nail Clippings", Color(0xffCAA376)],
    ["assets/images/needle.png", "Rabies Shot TBD", Color(0xffCA7676)],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.small(
        shape: CircleBorder(),
        backgroundColor: Colors.green,
        onPressed: () {
          print("Clicked");
        },
        child: Icon(Icons.add),
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
