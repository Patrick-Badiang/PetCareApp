import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:pet_care_app/taskModel.dart';
import 'package:pet_care_app/topWidget.dart';
import 'package:pet_care_app/utils/dialog_box.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Text Controller
  final _controller = TextEditingController();

  List _tasks = [
    ["Walk  the dog", false],
    ["Brush the dog", true],
    ["Feed the dog", false],
  ];

  void _taskClicked(bool? value, int index) {
    setState(() {
      _tasks[index][1] = !_tasks[index][1];
    });
  }

  void _addTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onAdd: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void saveNewTask() {
    setState(() {
      _tasks.add([_controller.text, false]);
    });
     Navigator.of(context).pop();
  }

  void deleteTask( int index){
    setState((){
    _tasks.removeAt(index);

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.small(
        shape: CircleBorder(),
        backgroundColor: Colors.green,
        onPressed: () {
          _addTask();
        },
        child: Icon(Icons.add),
      ),
      body: Column(
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
                  onDelete: (context) => deleteTask(index),
                );
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
      ),
    );
  }
}

class VetCard extends StatelessWidget {
  const VetCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
          color: Color.fromARGB(217, 217, 217, 217),
          borderRadius: BorderRadius.circular(15)),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10),
          Center(
            child: Text(
              'Vetenarian Information',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(height: 10),
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
          SizedBox(height: 10),
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
          SizedBox(height: 10),
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
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
