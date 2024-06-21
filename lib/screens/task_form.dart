import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../models/user.dart';
import '../models/priority.dart';
import '../providers/tasks_provider.dart';

enum FormMode { Add, Edit }

class TaskForm extends StatefulWidget {
  final FormMode formMode;
  final Task? task;

  const TaskForm({super.key, required this.formMode, this.task});

  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final _formKey = GlobalKey<FormState>();
  late String _id;
  late String _content;
  late DateTime _dueDate;
  late Priority _priority;
  late bool _completed;
  late DateTime _updatedAt;

  @override
  void initState() {
    super.initState();
    if (widget.formMode == FormMode.Edit) {
      _id = widget.task!.id;
      _content = widget.task!.content;
      _dueDate = widget.task!.dueDate;
      _priority = widget.task!.priority;
      _completed = widget.task!.completed;
      _updatedAt = widget.task!.updatedAt;
    } else {
      _content = '';
      _dueDate = DateTime.now();
      _priority = Priority.normal;
      _completed = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              initialValue: _content,
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
            if (widget.formMode == FormMode.Edit)
              ListTile(
                title: Text('Last Updated: ${_updatedAt.toString()}'),
                onTap: null, // Désactive le tap pour empêcher l'édition
              ),
            if(widget.formMode == FormMode.Edit)
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
              value: _priority,
              decoration: const InputDecoration(labelText: 'Priority'),
              items: Priority.values.map((Priority priority) {
                return DropdownMenuItem<Priority>(
                  value: priority,
                  child: Text(priority.toString().split('.').last),
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
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  final newTask = Task(
                    content: _content,
                    completed: _completed,
                    tags: [],
                    createdAt: widget.formMode == FormMode.Add ? DateTime.now() : widget.task!.createdAt,
                    updatedAt: DateTime.now(),
                    dueDate: _dueDate,
                    priority: _priority,
                  );
                  if (widget.formMode == FormMode.Add) {
                    Provider.of<TasksProvider>(context, listen: false).addTask(newTask);
                  } else if(widget.formMode == FormMode.Edit){
                    // Mettre à jour la tâche existante
                    newTask.id = widget.task!.id;
                    Provider.of<TasksProvider>(context, listen: false).updateTask(newTask);
                  }
                  Navigator.pop(context);
                }
              },
              child: Text(widget.formMode == FormMode.Add ? 'Add Task' : 'Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
