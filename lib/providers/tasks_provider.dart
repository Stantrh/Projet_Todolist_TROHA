import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/task_service.dart';
import 'package:collection/collection.dart';


class TasksProvider extends ChangeNotifier {
  final TaskService _taskService = TaskService();
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  Future<void> fetchTasks() async {
    _tasks = await _taskService.fetchTasks();
    notifyListeners();
  }

  void addTask(Task task) async {
    await _taskService.createTask(task);
    fetchTasks();
  }

  void removeTask(Task task) async{
    await _taskService.removeTask(task);
    fetchTasks();
  }

  void updateTask(Task task) async {
    await _taskService.updateTask(task);
    fetchTasks();
  }

  Task? getTaskById(String id) {
    return _tasks.firstWhereOrNull((task) => task.id == id);
  }
}
