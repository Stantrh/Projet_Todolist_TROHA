import 'package:flutter/material.dart';
import 'screens/tasks_master.dart';


class TodoListApp extends StatefulWidget{
  const TodoListApp({super.key});

  @override
  _TodoListAppState createState() => _TodoListAppState();
}

class _TodoListAppState extends State<TodoListApp>{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Todo List',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: TasksMaster(),
    );
  }

}