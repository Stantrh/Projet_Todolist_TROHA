import 'task.dart';
import 'package:uuid/uuid.dart';


var uuid = const Uuid();

class User {
  String id;
  String firstName;
  String lastName;
  String email;
  String password;
  List<Task> tasks;

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    List<Task>? tasks,
    String? id,
  })  : id = id ?? uuid.v4(),
        tasks = tasks ?? [];

  @override
  String toString() {
    return 'User(id: $id, firstName: $firstName, lastName: $lastName, email: $email)';
  }
}
