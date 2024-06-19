import 'package:faker/faker.dart';
import '../models/task.dart';
import '../models/user.dart';
import '../models/priority.dart';

class TaskService {
  final Faker _faker = Faker();
  List<Task> _tasks = [];

  Future<List<Task>> fetchTasks() async {
    // Simuler un délai pour représenter une opération I/O
    await Future.delayed(Duration(seconds: 2));

    if (_tasks.isEmpty) {
      _tasks = List.generate(100, (index) {
        return Task(
          author: User(
            firstName: _faker.person.firstName(),
            lastName: _faker.person.lastName(),
            email: _faker.internet.email(),
            password: _faker.internet.password(),
          ),
          content: _faker.lorem.sentence(),
          completed: _faker.randomGenerator.boolean(),
          tags: _faker.lorem.words(3).toList(),
          createdAt: _faker.date.dateTime(),
          updatedAt: _faker.date.dateTime(),
          dueDate: _faker.date.dateTime(),
          priority: Priority.values[_faker.randomGenerator.integer(Priority.values.length)],
        );
      });
    }

    return _tasks;
  }

  Future<void> createTask(Task task) async {
    _tasks.add(task);
  }
}