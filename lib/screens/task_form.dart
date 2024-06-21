import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../models/priority.dart';
import '../providers/tasks_provider.dart';

enum FormMode { Add, Edit }

class TaskForm extends StatefulWidget {
  final FormMode formMode;
  final Task? task;

  const TaskForm({Key? key, required this.formMode, this.task});

  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final _formKey = GlobalKey<FormState>();
  late String _content;
  late DateTime _dueDate;
  late Priority _priority;
  late bool _completed;

  @override
  void initState() {
    super.initState();
    if (widget.formMode == FormMode.Edit) {
      _content = widget.task!.content;
      _dueDate = widget.task!.dueDate;
      _priority = widget.task!.priority;
      _completed = widget.task!.completed;
    } else {
      _content = '';
      _dueDate = DateTime.now();
      _priority = Priority.normal;
      _completed = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.formMode == FormMode.Add ? 'Add Task' : 'Edit Task',
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blueAccent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  initialValue: _content,
                  decoration: const InputDecoration(
                    labelText: 'Content',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.text_fields, color: Colors.blueAccent),
                  ),
                  style: const TextStyle(color: Colors.black87),
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
                const SizedBox(height: 20),
                if (widget.formMode == FormMode.Edit)
                  ListTile(
                    title: Text(
                      'Last Updated: ${DateTime.now().toString()}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    onTap: null, // Disable tap to prevent editing
                  ),
                if (widget.formMode == FormMode.Edit)
                  SwitchListTile(
                    title: const Text(
                      'Completed',
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                    value: _completed,
                    activeColor: Colors.blueAccent,
                    onChanged: (bool value) {
                      setState(() {
                        _completed = value;
                      });
                    },
                  ),
                const SizedBox(height: 20),
                DropdownButtonFormField<Priority>(
                  value: _priority,
                  decoration: const InputDecoration(
                    labelText: 'Priority',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.priority_high, color: Colors.red),
                  ),
                  style: const TextStyle(color: Colors.black87),
                  items: Priority.values.map((Priority priority) {
                    return DropdownMenuItem<Priority>(
                      value: priority,
                      child: Text(
                        priority.toString().split('.').last,
                        style: const TextStyle(color: Colors.black87),
                      ),
                    );
                  }).toList(),
                  onChanged: (Priority? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _priority = newValue;
                      });
                    }
                  },
                  onSaved: (Priority? newValue) {
                    if (newValue != null) {
                      _priority = newValue;
                    }
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      final newTask = Task(
                        content: _content,
                        completed: _completed,
                        tags: [],
                        createdAt: widget.formMode == FormMode.Add
                            ? DateTime.now()
                            : widget.task!.createdAt,
                        updatedAt: DateTime.now(),
                        dueDate: _dueDate,
                        priority: _priority,
                      );
                      if (widget.formMode == FormMode.Add) {
                        Provider.of<TasksProvider>(context, listen: false)
                            .addTask(newTask);
                      } else if (widget.formMode == FormMode.Edit) {
                        newTask.id = widget.task!.id;
                        Provider.of<TasksProvider>(context, listen: false)
                            .updateTask(newTask);
                      }
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    widget.formMode == FormMode.Add ? 'Add Task' : 'Save Changes',
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
