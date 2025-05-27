import 'package:clean_starter/_core/app_router.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../_core/app_router.dart';
import '../../../modules/auth/bloc/auth_bloc.dart';

class Error401Page extends StatelessWidget {
  const Error401Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          final bool isAuthenticated = state.status == AuthStatus.authenticated;

          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.lock_outline, size: 64, color: Colors.redAccent),
                  const SizedBox(height: 16),
                  Text(
                    '401: Unauthorized Access',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    isAuthenticated
                        ? 'You do not have permission to view this page.\nPlease return to the home page.'
                        : 'You need to be logged in to access this page.\nPlease login or go to the landing page.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: () {
                      final route = isAuthenticated
                          ? firstNavRoute()
                          : (kIsWeb ? "/landing" : "/login");
                      context.go(route);
                    },
                    icon: const Icon(Icons.home),
                    label: Text(isAuthenticated
                        ? "Go to Home"
                        : kIsWeb
                            ? "Go to Landing"
                            : "Go to Login"),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
