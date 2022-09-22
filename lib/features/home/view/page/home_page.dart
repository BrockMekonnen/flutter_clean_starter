import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../auth/bloc/auth_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.person,
                size: 100,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('UserID: ${state.user.id}'),
                  Text('Name: ${state.user.firstName} ${state.user.lastName}'),
                  Text('Email: ${state.user.email}'),
                  Text('Phone: ${state.user.phone}'),
                ],
              ),
              const SizedBox(height: 30),
              Wrap(
                spacing: 20,
                children: [
                  ElevatedButton(
                    child: const Text('Logout'),
                    onPressed: () {
                      context.read<AuthBloc>().add(AuthLogoutRequested());
                    },
                  ),
                  ElevatedButton(
                    child: const Text('Detail'),
                    onPressed: () {
                      GoRouter.of(context).go('/home/details');
                    },
                  ),
                ],
              ),
            ],
          );
        },
      )),
    );
  }
}
