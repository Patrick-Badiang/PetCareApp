
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ToDoDatabase {

  List tasks = [];

  //reference  box
  final _myBox = Hive.box('mybox');

  //method  for initial  task  values
  void createInitialData(){
    tasks = [
      ["Add a task, click plus button", false],
    ];
  }

  //load data from database
  void loadData(){
    var loadedTasks = _myBox.get("TASKS");
  if (loadedTasks != null) {
    tasks = loadedTasks;
  }
  }

  //update database
  void updateDataBase(){
    _myBox.put("TASKS", tasks);
  }
}

class AppointmentDatabase {

  List appointments = [];

  //reference  box
  final _myBox = Hive.box('appointments');

  //method  for initial  task  values
  void createInitialData(){
    appointments = [
      ["assets/images/clock.png", "Click plus button", Color(0xff719BDA)],
    ];
  }

  //load data from database
  void loadData(){
    var loadedApps = _myBox.get("APPOINTMENTS");
  if (loadedApps != null) {
    appointments = loadedApps;
  }
  }

  //update database
  void updateDataBase(){
    _myBox.put("APPOINTMENTS", appointments);
  }
}