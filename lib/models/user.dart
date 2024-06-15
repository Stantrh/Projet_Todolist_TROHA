import 'task.dart';

class User{

  String id; // identifiant
  final String firstname; // prénom
  final String lastname; // nom
  final String email; // email
  final String password; // mot de passe
  final List<Task> tasks; // liste de tâches dont l'user est l'auteur


  User({
    String? id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.password,
    this.tasks = const [], // Un utilisateur peut être créé sans tâches de base, souvent le cas
  }) : id = id ?? uuid.v4();
}