import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter/cupertino.dart';

class TaskModel {
  final String taskName;
  bool isDone;
  final Color boxColor;
  // final Function(bool?)? onChanged;

  TaskModel({
    required this.taskName,
    required this.isDone,
    // required this.onChanged,
    required this.boxColor,
  });

  static List<TaskModel> getTasks() {
    List<TaskModel> tasks = [];

    tasks.add(TaskModel(
        taskName: "Walk the Dog", isDone: false, boxColor: Color(0xffCA7676)));
    tasks.add(TaskModel(
        taskName: "Brush the Dog", isDone: false, boxColor: Color(0xffCAA376)));
    tasks.add(TaskModel(
        taskName: "Feed the Dog", isDone: false, boxColor: Color(0xffCA7676)));
    tasks.add(TaskModel(
        taskName: "Brush the Dog", isDone: false, boxColor: Color(0xffCAA376)));
    tasks.add(TaskModel(
        taskName: "Walk the Dog", isDone: false, boxColor: Color(0xffCA7676)));
    return tasks;
  }
}

class TaskTile extends StatelessWidget {
  final String taskName;
  final bool isDone;
  final Function(bool?)? onChanged;

  const TaskTile({
    required this.taskName,
    required this.isDone,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Container(
        height: 50,
        child: Row(
          children: [
            //Check Box
            Checkbox(
              focusColor: Color(0xffFFFAFA),
              value: isDone,
              onChanged: onChanged,
              activeColor: Colors.black,
            ),

            //Task Name
            Container(
                height: 30,
                width: 300,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left:10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color(0XFFD9D9D9),
                ),
                child: Text(taskName),
                ),
          ],
        ),
      ),
    );
  }
}
