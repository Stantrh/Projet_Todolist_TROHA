import 'user.dart';
import 'task.dart';


void main() {
  User user1 = User(
    firstName: 'John',
    lastName: 'Doe',
    email: 'john.doe@example.com',
    password: 'passwdfeur',
  );

  User user2 = User(
    firstName: 'Jane',
    lastName: 'Smith',
    email: 'jane.smith@example.com',
    password: 'passwtalmofn',
  );
  Task tache1 = Task(author: user2, content: 'Faire la vaisselle');
  Task tache2 = Task(author: user1, content: 'Coucou', completed: true);
  user2.tasks.add(tache1);


  print(user1);
  print(user2);
  print(tache1);
  print(tache2);
}
