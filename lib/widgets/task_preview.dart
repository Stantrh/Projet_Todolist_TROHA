import 'package:flutter/material.dart';
import '../models/task.dart';
import '../screens/task_form.dart';
import '../providers/tasks_provider.dart';
import 'package:provider/provider.dart';

class TaskPreview extends StatelessWidget {
  final Task task;

  TaskPreview({required this.task});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        task.completed ? Icons.check_circle : Icons.circle,
        color: task.completed ? Colors.lightGreen : Colors.grey,
      ),
      title: Text(task.content),
      tileColor: task.completed ? Colors.green[100] : Colors.white54,
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => Dialog(
            child: TaskForm(formMode: FormMode.Edit, task: task),
          ),
        );
      },
      trailing: IconButton(
        icon: const Icon(Icons.delete, color: Colors.red),
        onPressed: () {
          Provider.of<TasksProvider>(context, listen: false).removeTask(task);
        },
      ),
    );
  }
}