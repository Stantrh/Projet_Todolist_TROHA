import 'user.dart';
import 'priority.dart';

class Task {
  String id;
  final String? author;
  String content;
  List<String> tags;
  bool completed;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime dueDate;
  Priority priority;

  Task({
    this.author,
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

  factory Task.fromJson(Map<String, dynamic> json) {
    DateTime? updatedAt;
    if (json.containsKey('updated_at') && json['updated_at'] != null) {
      updatedAt = DateTime.parse(json['updated_at']);
    }

    return Task(
      id: json['id'],
      author: json['id_user'],
      content: json['content'],
      priority: Priority.values.firstWhere((e) => e.toString() == 'Priority.${json['priority']}'),
      completed: json['completed'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'id': id,
      'content': content,
      'priority': priority.toString().split('.').last,
      'completed' : completed
    };
    if (createdAt != null){
      json['created_at'] = createdAt!.toIso8601String();
    }
    if (updatedAt != null){
      json['updated_at'] = updatedAt!.toIso8601String();
    }

    if (author != null) {
      json['user_id'] = author;
    }
      return json;
  }
  @override
  String toString() {
    return 'Task(id: $id, author: $author, content: $content, completed: $completed, createdAt: $createdAt, updatedAt: $updatedAt, dueDate: $dueDate)';
  }
}
