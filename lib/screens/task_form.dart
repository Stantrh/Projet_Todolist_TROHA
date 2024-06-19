import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../models/user.dart';
import '../models/priority.dart';
import '../providers/tasks_provider.dart';

class TaskForm extends StatefulWidget {
  const TaskForm({super.key});

  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final _formKey = GlobalKey<FormState>();
  String _content = '';
  bool _completed = false;
  final DateTime _dueDate = DateTime.now();
  Priority _priority = Priority.normal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'Content'),
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
                title: const Text('Completed'),
                value: _completed,
                onChanged: (bool value) {
                  setState(() {
                    _completed = value;
                  });
                },
              ),
              DropdownButtonFormField<Priority>(
                decoration: const InputDecoration(labelText: 'Priority'),
                value: _priority,
                items: Priority.values.map((Priority priority) {
                  return DropdownMenuItem<Priority>(
                    value: priority,
                    child: Text(priority.toString().split('.').last),
                  );
                }).toList(),
                onChanged: (Priority? newValue) {
                  setState(() {
                    _priority = newValue!;
                  });
                },
                onSaved: (Priority? newValue) {
                  _priority = newValue!;
                },
              ),
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
                    Provider.of<TasksProvider>(context, listen: false).addTask(newTask);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Task added')),
                    );
                    Navigator.pop(context, newTask);
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}