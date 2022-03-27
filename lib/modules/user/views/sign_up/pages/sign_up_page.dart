import 'package:auto_route/auto_route.dart';
import 'package:clean_flutter/_core/router/router.gr.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign Up")),
      body: Center(
        child: ElevatedButton(
          style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(const Size(250, 50)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)))),
          child: const Text("Login"),
          onPressed: () {
            AutoRouter.of(context).push(const LoginRoute());
          },
        ),
      ),
    );
  }
}
