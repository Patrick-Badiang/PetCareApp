import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TaskTile extends StatelessWidget {
  final String taskName;
  final bool isDone;
  Function(bool?)? onChanged;
  Function(BuildContext?)? onDelete;

  TaskTile({
    required this.taskName,
    required this.isDone,
    required this.onChanged,
    required this.onDelete,
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
              focusColor: Colors.white,
              value: isDone,
              onChanged: onChanged,
              activeColor: Colors.white,
              checkColor: Colors.black,
            ),

            //Task Name
            Slidable(
              endActionPane: ActionPane(
                motion: StretchMotion(),
                children: [
                  SlidableAction(
                    onPressed: onDelete,
                    icon: Icons.delete,
                    backgroundColor: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  )
                ],
              ),
              child: Container(
                height: 40,
                width: 300,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Color(0XFFD9D9D9),
                ),
                child: Row(
                  children: [
                    Text(
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        decoration: isDone
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                      taskName,
                    ),
                    Spacer(),
                    Container(
                        child: isDone
                            ? IconButton(
                                onPressed: () => onDelete?.call(context),
                                icon: Icon(Icons.delete))
                            : null),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
