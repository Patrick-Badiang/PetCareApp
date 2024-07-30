// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';

// ignore: must_be_immutable
class TaskTile extends StatelessWidget {
  final DocumentSnapshot document;
  Function(bool?)? onChanged;
  Function(BuildContext?)? onDelete;

  TaskTile({
    super.key, 
    required this.document,
    required this.onChanged,
    required this.onDelete,
  });


  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50,
        child: Row(
          children: [
            //Check Box

            Checkbox(
              focusColor: Colors.white,
              value: document['isDone'],
              onChanged: onChanged,
              activeColor: Colors.white,
              checkColor: Colors.black,
            ),

            //Task Name
            Slidable(
              endActionPane: ActionPane(
                motion: const StretchMotion(),
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
                  color: const Color(0XFFD9D9D9),
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
                      document['task'],
                    ),
                    const Spacer(),
                    Container(
                        child: isDone
                            ? IconButton(
                                onPressed: () => onDelete?.call(context),
                                icon: const  Icon(Icons.delete))
                            : null),
                  ],
                ),
              ),
            ),
          ],
        ),
      
    );
  }
}
