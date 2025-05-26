import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../modules/auth/bloc/auth_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          context.go('/home');
        } else {
          String route = kIsWeb ? "/landing" : "login";
          context.go(route);
        }
      },
      child: Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Center(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FlutterLogo(),
              const SizedBox(height: 15),
              const SizedBox(
                width: 40,
                child: LinearProgressIndicator(),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
