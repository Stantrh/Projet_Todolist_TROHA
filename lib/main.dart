import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/providers/tasks_provider.dart';
import 'todo_list_app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(ChangeNotifierProvider(create: (context) => TasksProvider()..fetchTasks(),
  child: TodoListApp(),
  ));
}
