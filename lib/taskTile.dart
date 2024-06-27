import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter/cupertino.dart';

class TaskTile extends StatelessWidget {
  final String taskName;
  final bool isDone;
  final Function(bool?)? onChanged;


  const TaskTile({super.key, required this.taskName, required this.isDone, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Card(
                child: Row(
                  children: <Widget>[
                    Checkbox(value: isDone, onChanged: onChanged),
                    Text(taskName),
                  ]
                )
              ),
            );
  }
}