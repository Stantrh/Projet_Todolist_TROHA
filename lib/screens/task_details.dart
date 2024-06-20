// import 'package:flutter/material.dart';
// import '../models/task.dart';
// import 'package:intl/intl.dart';
// import 'task_form.dart';
//
// class TaskDetails extends StatefulWidget {
//   final Task task;
//   final DateFormat format;
//
//   TaskDetails({super.key, required this.task, DateFormat? format})
//   : format = format ?? DateFormat('yyyy-MM-dd HH:mm');
//
//   @override
//   _TaskDetailsState createState() => _TaskDetailsState();
// }
//
// class _TaskDetailsState extends State<TaskDetails> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Task Details'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Content: ${widget.task.content}', style: const TextStyle(fontSize: 18)),
//             const SizedBox(height: 10),
//             Text('Created at: ${widget.format.format(widget.task.createdAt)}', style: const TextStyle(fontSize: 18)),
//             Text('Last updated at: ${widget.format.format(widget.task.updatedAt)}', style: const TextStyle(fontSize: 18)),
//             Text('Tags: ${widget.task.tags}', style: const TextStyle(fontSize: 18)),
//             Text('Due at: ${widget.format.format(widget.task.dueDate)}', style: const TextStyle(fontSize: 18)),
//             Text('Completed: ${widget.task.completed}', style: const TextStyle(fontSize: 18)),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           showDialog(
//             context: context,
//             builder: (context) => const Dialog(
//               child: TaskForm(formMode: FormMode.Add),
//             ),
//           );
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Si nécessaire pour le format des dates
import '../models/task.dart';
import 'task_form.dart'; // Importez TaskForm

class TaskDetails extends StatelessWidget {
  final Task task;
  final DateFormat format;

  TaskDetails({Key? key, required this.task, DateFormat? format})
      : format = format ?? DateFormat('yyyy-MM-dd HH:mm'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Content: ${task.content}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Created at: ${format.format(task.createdAt)}', style: const TextStyle(fontSize: 18)),
            Text('Last updated at: ${format.format(task.updatedAt)}', style: const TextStyle(fontSize: 18)),
            Text('Tags: ${task.tags}', style: const TextStyle(fontSize: 18)),
            Text('Due at: ${format.format(task.dueDate)}', style: const TextStyle(fontSize: 18)),
            Text('Completed: ${task.completed}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Afficher TaskForm en tant que boîte de dialogue pour éditer la tâche
                showDialog(
                  context: context,
                  builder: (context) => Dialog(
                    child: TaskForm(formMode: FormMode.Edit, task: task),
                  ),
                );
              },
              child: const Text('Edit Task'),
            ),
          ],
        ),
      ),
    );
  }
}