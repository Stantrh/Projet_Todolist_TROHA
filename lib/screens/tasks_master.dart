import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/task_preview.dart';
import '../providers/tasks_provider.dart';
import 'task_form.dart';

class TasksMaster extends StatelessWidget {
  const TasksMaster({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks Master'),
        leading: const Icon(Icons.gesture_sharp, color: Colors.blue),
      ),
      body: FutureBuilder(
        future: Provider.of<TasksProvider>(context, listen: false).fetchTasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Consumer<TasksProvider>(
              builder: (context, tasksProvider, child) {
                final tasks = tasksProvider.tasks;
                if (tasks.isEmpty) {
                  return const Center(child: Text('No tasks available'));
                }
                return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return TaskPreview(task: task);
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const Dialog(
              child: TaskForm(formMode: FormMode.Add),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
