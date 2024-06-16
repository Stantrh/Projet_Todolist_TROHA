import 'package:flutter/material.dart';
import '../models/task.dart';
import '../screens/task_details.dart';

class TaskPreview extends StatelessWidget {
  final Task task;

  TaskPreview({required this.task});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        task.completed ? Icons.check_circle : Icons.circle,
        color: task.completed ? Colors.green : Colors.red,
      ),
      title: Text(task.content),
      tileColor: task.completed ? Colors.green[100] : Colors.red[100],
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TaskDetails(task: task),
          ),
        );
      },
    );
  }
}