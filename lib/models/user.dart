import 'task.dart';
import 'package:uuid/uuid.dart';


var uuid = const Uuid();

class User {
  String id;
  String email;
  String password;
  List<Task> tasks;

  User({
    required this.email,
    required this.password,
    List<Task>? tasks,
    String? id,
  })  : id = id ?? uuid.v4(),
        tasks = tasks ?? [];

  @override
  String toString() {
    return 'User(id: $id, email: $email)';
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      password: json['encrypted_password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'encrypted_password': password,
    };
  }
}
