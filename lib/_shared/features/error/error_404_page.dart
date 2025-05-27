import 'package:clean_starter/_core/app_router.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Error404Page extends StatelessWidget {
  const Error404Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.search_off, size: 64, color: Colors.orangeAccent),
              const SizedBox(height: 16),
              Text(
                '404: Page Not Found',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.orangeAccent,
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                "The page you are looking for does not exist or has been moved.",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: () {
                  final route = kIsWeb ? "/landing" : firstNavRoute();
                  context.go(route);
                },
                icon: const Icon(Icons.home),
                label: const Text("Go to Home"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
