import 'package:flutter/material.dart';
import '../models/task.dart';
import '../models/user.dart';
import '../models/priority.dart';
import '../services/task_service.dart';

class TaskForm extends StatefulWidget {
  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final _formKey = GlobalKey<FormState>();
  final TaskService _taskService = TaskService();
  String _content = '';
  bool _completed = false;
  DateTime _dueDate = DateTime.now();
  Priority _priority = Priority.normal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Content'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some content';
                  }
                  return null;
                },
                onSaved: (value) {
                  _content = value!;
                },
              ),
              SwitchListTile(
                title: Text('Completed'),
                value: _completed,
                onChanged: (bool value) {
                  setState(() {
                    _completed = value;
                  });
                },
              ),
              // Add other form fields like date and priority here
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final newTask = Task(
                      author: User(
                        firstName: 'John', // Replace with actual user data
                        lastName: 'Doe',
                        email: 'john.doe@example.com',
                        password: 'password',
                      ),
                      content: _content,
                      completed: _completed,
                      tags: [],
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                      dueDate: _dueDate,
                      priority: _priority,
                    );
                    _taskService.createTask(newTask).then((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Task added')),
                      );
                      Navigator.pop(context, newTask);
                    });
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}