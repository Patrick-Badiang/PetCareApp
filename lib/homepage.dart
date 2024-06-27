import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:pet_care_app/taskTile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        color: const Color.fromARGB(217, 229, 229, 229),
        child:  const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Center(child: VetCard()),
            const Padding(
              padding: EdgeInsets.only(left: 30.0, top: 30.0),
              child: Text("Daily Tasks"),
            ),
            Flexible(
              fit: FlexFit.tight,
              child: DailyTasks()),
            // const DailyTasks(),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 30.0),
            //   child: Card(
            //     child: ListTile(
            //       leading: const Icon(Icons.add_box_outlined),
            //       onTap: () {
            //         print("Hello");
            //       },
            //       title: const Opacity(
            //         opacity: 0.6,
            //         child: Text("Add a Task"),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ));
  }
}

class DailyTasks extends StatefulWidget {
  const DailyTasks({super.key});

  @override
  State<DailyTasks> createState() => _DailyTasksState();
}

class _DailyTasksState extends State<DailyTasks> {
  List tasks = [
    ["Test", false],
    ["Test2", true],
    ["Test3", true],
    


  ];

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      tasks[index][1] = !tasks[index][1];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return Container(height: 10,  color: Colors.black,);
        },
      ),
    );
  }
}

class VetCard extends StatelessWidget {
  const VetCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
      child: Card(
        color: Color.fromARGB(217, 217, 217, 217),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Text(
                'Vetenarian Information',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  Text(
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 10,
                    ),
                    'Name:',
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30.0),
                    child: Text(
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                      'Duck Creek Animal Hospital',
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  Text(
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 10,
                    ),
                    'Number:',
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                      '(302) 653-2300',
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  Text(
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 10,
                    ),
                    'Location:',
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                      'Smryna, DE',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
