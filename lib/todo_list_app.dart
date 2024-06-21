import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'screens/signin.dart';
import 'screens/tasks_master.dart';
import 'providers/user_provider.dart';

class TodoListApp extends StatelessWidget {
  const TodoListApp({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    final GoRouter router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => userProvider.isAuthenticated ? const TasksMaster() : const SignIn(),
        ),
        GoRoute(
          path: '/tasks',
          builder: (context, state) => const TasksMaster(),
        ),
      ],
      redirect: (context, state) {
        final isAuthenticated = userProvider.isAuthenticated;
        final isLoggingIn = state.matchedLocation == '/';

        if (!isAuthenticated && !isLoggingIn) return '/';
        if (isAuthenticated && isLoggingIn) return '/tasks';
        return null;
      },
    );

    return MaterialApp.router(
      routerConfig: router,
    );
  }
}
