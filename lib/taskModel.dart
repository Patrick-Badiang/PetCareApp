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
  final Color boxColor;
  final Function(bool?)? onChanged;

  const TaskTile({
    required this.taskName,
    required this.isDone,
    required this.onChanged,
    required this.boxColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: boxColor,
        ),
        child: Row(
          children: [
            //Check Box
            Checkbox(
              value: isDone,
              onChanged: onChanged,
            ),
            //Task Name
            Text(taskName),
          ],
        ),
      ),
    );
  }
}
