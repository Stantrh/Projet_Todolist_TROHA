import 'package:flutter/material.dart';


void main(){
  runApp(const TodoListApp());
}

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
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Todo List'),
            ),
            body: const Center(
              child: Text('Pour le TP Flutter'),
            )
        )
    );
  }

}