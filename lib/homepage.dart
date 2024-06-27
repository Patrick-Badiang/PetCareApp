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

  void _getTasks() {
    tasks = TaskModel.getTasks();
    print(tasks[1].boxColor);
  }

  @override
  Widget build(BuildContext context) {
    _getTasks();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        // TopWidget(subText: "My Name is:", title: "Kuber Badiang"),
        const Center(child: VetCard()),
        const SizedBox(height: 40),
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
              itemCount: tasks.length,
              separatorBuilder: (context, index) => SizedBox(width: 25),
              itemBuilder: (context, index) {
                return Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: tasks[index].boxColor,
                  ),
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
    );
  }
}
