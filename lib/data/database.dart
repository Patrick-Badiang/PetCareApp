import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ToDoDatabase {
  List tasks = [];

  //reference  box
  final _myBox = Hive.box('mybox');

  //method  for initial  task  values
  void createInitialData() {
    tasks = [
      ["Add a task, click plus button", false],
    ];
  }

  //load data from database
  void loadData() {
    var loadedTasks = _myBox.get("TASKS");
    if (loadedTasks != null) {
      tasks = loadedTasks;
    }
  }

  //update database
  void updateDataBase() {
    _myBox.put("TASKS", tasks);
  }
}

class AppointmentDatabase {
  List appointments = [];

  //reference  box
  final _myBox = Hive.box('mybox');

  //method  for initial  task  values
  void createInitialData() {
    appointments = [
      ["assets/images/clock.png", "Click plus button", Color(0xff719BDA)],
    ];
  }

  //load data from database
  void loadData() {
    var loadedApps = _myBox.get("APPOINTMENTS");
    if (loadedApps != null) {
      appointments = loadedApps;
    }
  }

  //update database
  void updateDataBase() {
    _myBox.put("APPOINTMENTS", appointments);
  }
}

class CaringDatabase {
  List vets = [];
  List likes = [];

  //reference  box
  final _myBox = Hive.box('mybox');


  //method  for initial  task  values
  void createInitialData() {
    //0xffCAA376
    vets = [
      [true,"Click plus button"],
    ];

    likes = [
      [false, "Click plus button"],
    ];
  }

  //load data from database
  void loadData() {
    var loadedVet = _myBox.get("VETS");
    if (loadedVet != null) {
      vets = loadedVet;
    }

    var loadedLikes = _myBox.get("LIKES");
    if (loadedLikes != null) {
      likes = loadedLikes;
    }
  }

  //update database
  void updateDataBase() {
    _myBox.put("VETS", vets);
    _myBox.put("LIKES", likes);
  }
}
