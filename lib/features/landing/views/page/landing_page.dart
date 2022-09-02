import 'package:clean_flutter/_core/router/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Template'),
        actions: [
          TextButton.icon(
            onPressed: () {
              context.goNamed(loginRouteName);
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
              context.goNamed(registerRouteName);
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
