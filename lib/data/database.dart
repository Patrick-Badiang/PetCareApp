

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