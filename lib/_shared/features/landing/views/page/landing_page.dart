import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';


class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const FlutterLogo(size: 40),
            if (ResponsiveBreakpoints.of(context).largerOrEqualTo(TABLET))
              const Text(' Clean Starter'),
          ],
        ),
        actions: [
          TextButton.icon(
            onPressed: () => context.go("/login"),
            icon: const Icon(Icons.login),
            label: const Text('Login'),
          ),
          TextButton.icon(
            onPressed: () => context.go("/register"),
            icon: const Icon(Icons.person_add),
            label: const Text('Register'),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome to ',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const FlutterLogo(size: 40),
                Text(
                  ' Clean Starter',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              constraints: const BoxConstraints(maxWidth: 750),
              child: const Text(
                'This is a template project for Flutter that follows Clean Architecture and Modular Architecture principles. '
                'The goal of this project is to provide a basic structure that can be used as a starting point for building '
                'Flutter applications that are well-organized, maintainable, and scalable.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, wordSpacing: 1.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}