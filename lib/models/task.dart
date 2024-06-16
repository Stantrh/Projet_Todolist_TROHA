import 'priority.dart';
import 'user.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class Task {
  String id;
  User author;
  String content;
  List<String> tags;
  bool completed;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime dueDate;
  Priority priority;

  Task({
    required this.author,
    required this.content,
    this.tags = const [],
    this.completed = false,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? dueDate,
    this.priority = Priority.normal,
    String? id,
  })  : id = id ?? uuid.v4(),
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now(),
        dueDate = dueDate ?? DateTime.now().add(const Duration(days: 7));

  @override
  String toString() {
    return 'Task(id: $id, author: ${author.id}, content: $content, completed: $completed, createdAt: $createdAt, updatedAt: $updatedAt, dueDate: $dueDate)';
  }
}