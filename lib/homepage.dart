import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:pet_care_app/taskModel.dart';
import 'package:pet_care_app/topWidget.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TaskModel> tasks = [];

  List _tasks = [
    ["Walk  the dog", false, Color(0xffCA7676)],
    ["Brush the dog", true, Color(0xffCAA376)],
    ["Feed the dog", false, Color(0xffCA7676)],
  ];

  void _getTasks() {
    tasks = TaskModel.getTasks();
    print(tasks[1].boxColor);
  }

  void _taskClicked(bool? value, int index) {
    // setState(() {
    //   tasks[index].isDone = !tasks[index].isDone;
    // });
  }

  @override
  Widget build(BuildContext context) {
    _getTasks();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        TopWidget(subText: "My Name is:", title: "Kuber Badiang"),
        SizedBox(height: 20),
        const Center(child: VetCard()),
        const SizedBox(height: 30),
        const Padding(
          padding: EdgeInsets.only(left: 30.0),
          child: Text("Daily Tasks"),
        ),
        const SizedBox(height: 15),
        Expanded(
          // Wrap the Container in an Expanded widget
          child: ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: _tasks.length,
            separatorBuilder: (context, index) => SizedBox(height: 10),
            itemBuilder: (context, index) {
              return TaskTile(
                  taskName: _tasks[index][0],
                  isDone: _tasks[index][1],
                  onChanged: (value) => _taskClicked(value, index),
                  boxColor: _tasks[index][2]);
            },
          ),
        ),

        // DailyTasks(),
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
    );
  }
}

class VetCard extends StatelessWidget {
  const VetCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      decoration: BoxDecoration(
          color: Color.fromARGB(217, 217, 217, 217),
          borderRadius: BorderRadius.circular(15)),
      child: const Column(
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
    );
  }
}
