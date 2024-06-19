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

  void addTask(Task task) {
    _taskService.createTask(task);
    notifyListeners();
  }

  void removeTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }

  // Task? getTaskById(String id) {
  //   return _tasks.firstWhere((task) => task.id == id, orElse: () => null);
  // }
  Task? getTaskById(String id) {
    return _tasks.firstWhereOrNull((task) => task.id == id);
  }
}
