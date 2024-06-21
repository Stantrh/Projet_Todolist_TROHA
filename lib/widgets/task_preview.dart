import 'package:flutter/material.dart';
import '../models/task.dart';
import '../screens/task_form.dart';
import '../providers/tasks_provider.dart';
import 'package:provider/provider.dart';
import '../models/priority.dart';

class TaskPreview extends StatelessWidget {
  final Task task;

  const TaskPreview({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    Color? priorityColor;
    switch (task.priority) {
      case Priority.low:
        priorityColor = Colors.blue[100];
        break;
      case Priority.normal:
        priorityColor = Colors.green[300];
        break;
      case Priority.high:
        priorityColor = Colors.yellow[200];
        break;
      default:
        priorityColor = Colors.white;
    }

    return GestureDetector(
      onTap: () {
        _showTaskDetails(context);
      },
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: priorityColor, // Définir la couleur de fond de la carte ici
        child: Container(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Icon(
                  task.completed ? Icons.check_circle : Icons.circle,
                  color: task.completed ? Colors.lightGreen : Colors.grey,
                ),
              ),
              Expanded(
                flex: 8,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    task.content,
                    style: TextStyle(
                      fontSize: 16,
                      decoration: task.completed ? TextDecoration.lineThrough : TextDecoration.none,
                      color: task.completed ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    _confirmDelete(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showTaskDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: TaskForm(formMode: FormMode.Edit, task: task),
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Do you really want to delete this task?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Provider.of<TasksProvider>(context, listen: false).removeTask(task);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
