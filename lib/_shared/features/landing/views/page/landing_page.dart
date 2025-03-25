import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Template'),
        actions: [
          TextButton.icon(
            onPressed: () {
              context.go("/login");
            },
            icon: Icon(
              Icons.login,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            label: Text(
              'Login',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
          TextButton.icon(
            onPressed: () {
              context.go("/register");
            },
            icon: Icon(
              Icons.person_add,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            label: Text(
              'Register',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Text(
          'Landing Page',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
