import 'package:flutter/material.dart';
import '../services/task_service.dart';
import '../widgets/task_preview.dart';
import '../models/task.dart';

class TasksMaster extends StatelessWidget {
  final TaskService _taskService = TaskService();

  TasksMaster({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks Master'),
      ),
      body: FutureBuilder<List<Task>>(
        future: _taskService.fetchTasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final tasks = snapshot.data!;
            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return TaskPreview(task: task);
              },
            );
          } else {
            return const Center(child: Text('No tasks found'));
          }
        },
      ),
    );
  }
}