import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/providers/tasks_provider.dart';
import 'todo_list_app.dart';


void main() {
  runApp(ChangeNotifierProvider(create: (context) => TasksProvider()..fetchTasks(),
  child: TodoListApp(),
  ));
}
