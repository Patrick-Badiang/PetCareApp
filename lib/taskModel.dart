import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter/cupertino.dart';

class TaskModel {
  final String taskName;
  final bool isDone;
  final Color boxColor;
  // final Function(bool?)? onChanged;

  const TaskModel({
    required this.taskName,
    required this.isDone,
    // required this.onChanged,
    required this.boxColor,
  });

  static List<TaskModel> getTasks() {
    List<TaskModel> tasks = [];

    tasks.add(
      const TaskModel(
        taskName: "Walk the Dog",
        isDone: false,
        boxColor: Color(0xffCA7676)));
    tasks.add(
      const TaskModel(
        taskName: "Brush the Dog",
        isDone: false,
        boxColor: Color(0xffCAA376)));
    tasks.add(
      const TaskModel(
        taskName: "Feed the Dog",
        isDone: false,
        boxColor: Color(0xffCA7676)));
    tasks.add(
      const TaskModel(
        taskName: "Brush the Dog",
        isDone: false,
        boxColor: Color(0xffCAA376)));
    tasks.add(
      const TaskModel(
        taskName: "Walk the Dog",
        isDone: false,
        boxColor: Color(0xffCA7676)));
    return tasks;
  }
}
