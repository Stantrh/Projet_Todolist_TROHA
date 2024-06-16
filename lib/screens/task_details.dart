import 'package:flutter/material.dart';
import '../models/task.dart';
import 'package:intl/intl.dart';

class TaskDetails extends StatefulWidget {
  final Task task;
  final DateFormat format;

  TaskDetails({super.key, required this.task, DateFormat? format})
  : format = format ?? DateFormat('yyyy-MM-dd HH:mm');

  @override
  _TaskDetailsState createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
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
            Text('Content: ${widget.task.content}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Created at: ${widget.format.format(widget.task.createdAt)}', style: const TextStyle(fontSize: 18)),
            Text('Last updated at: ${widget.format.format(widget.task.updatedAt)}', style: const TextStyle(fontSize: 18)),
            Text('Tags: ${widget.task.tags}', style: const TextStyle(fontSize: 18)),
            Text('Due at: ${widget.format.format(widget.task.dueDate)}', style: const TextStyle(fontSize: 18)),
            Text('Completed: ${widget.task.completed}', style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}