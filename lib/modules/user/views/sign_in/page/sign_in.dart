import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../../../_core/ui/bloc/auth/auth_bloc.dart';
import '../../../../../_core/di/get_It.dart';
import '../../../../../_core/router/router.gr.dart';
import '../bloc/login_bloc.dart';

class Credentials {
  final String phone;
  final String password;

  Credentials(this.phone, this.password);
}

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(1),
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: ((context, state) {
            if (state is Unauthenticated) {
              return _AuthForm();
            }
            if (state is AuthFailure) {
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(state.message),
                  TextButton(
                    child: const Text('Retry'),
                    onPressed: () {
                      final authBloc = BlocProvider.of<AuthBloc>(context);
                      authBloc.add(AppLoaded());
                    },
                  )
                ],
              ));
            }
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _AuthForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: BlocProvider<LoginBloc>(
        create: (context) => container(),
        child: _SignInForm(),
      ),
    );
  }
}

class _SignInForm extends StatefulWidget {
  @override
  State<_SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<_SignInForm> {
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    void _showError(String error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error)));
    }

    return BlocConsumer<LoginBloc, LoginState>(
      listener: ((context, state) {
        if (state is LoginFailure) {
          _showError(state.error);
        }
      }),
      builder: (context, state) {
        if (state is LoginLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: ResponsiveValue<double>(context,
                    defaultValue: 100.0,
                    valueWhen: [
                      const Condition.smallerThan(name: MOBILE, value: 60.0),
                      const Condition.largerThan(name: MOBILE, value: 160.0),
                    ]).value,
                child: Image.asset('assets/images/logo.png'),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Clean Flutter',
                style: TextStyle(
                    color: Color.fromARGB(255, 51, 0, 0), fontSize: 14),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: ResponsiveValue<double>(context,
                    defaultValue: 480.0,
                    valueWhen: [
                      const Condition.smallerThan(name: MOBILE, value: 480.0),
                      const Condition.equals(name: MOBILE, value: 520.0),
                      const Condition.largerThan(name: MOBILE, value: 600.0),
                    ]).value,
                width: ResponsiveValue<double>(context,
                    defaultValue: 300.0,
                    valueWhen: [
                      const Condition.equals(name: MOBILE, value: 400.0),
                      const Condition.equals(name: TABLET, value: 500.0),
                      const Condition.equals(name: DESKTOP, value: 540.0),
                    ]).value,
                padding: EdgeInsets.all(ResponsiveValue<double>(context,
                        defaultValue: 20.0,
                        valueWhen: [
                          const Condition.equals(name: MOBILE, value: 50.0),
                          const Condition.largerThan(name: MOBILE, value: 80.0),
                        ]).value ??
                    20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'LOGIN',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 5, 5, 5)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      phoneFormField(),
                      const SizedBox(
                        height: 10,
                      ),
                      passwordFormField(),
                      forgotPasswordButton(context),
                      const SizedBox(
                        height: 20,
                      ),
                      loginButton(state, context),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              context.router.push(const SignUpRoute());
                            },
                            child: const Text("Sign Up"),
                          ),
                        ],
                      ),
                    ]),
              )
            ],
          ),
        );
      },
    );
  }

  ElevatedButton loginButton(LoginState state, BuildContext context) {
    return ElevatedButton.icon(
      style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(const Size(250, 50)),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))),
      onPressed: () async {
        var _loginBloc = BlocProvider.of<LoginBloc>(context);
        _loginBloc.add(LoginInSubmitted(
            email: _phoneController.text, password: _passwordController.text));
      },
      icon: const Icon(
        Icons.login,
        size: 18,
      ),
      label: const Text("LOGIN"),
    );
  }

  Padding forgotPasswordButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () {
              context.router.push(const SignUpRoute());
            },
            child: const Text("Forget Password?"),
          ),
        ],
      ),
    );
  }

  TextFormField passwordFormField() {
    return TextFormField(
      obscureText: true,
      decoration: const InputDecoration(
          labelText: "Password", suffixIcon: Icon(Icons.visibility_off)),
      controller: _passwordController,
      validator: (value) {
        if (value == null) {
          return 'Password is required.';
        }
        return null;
      },
    );
  }

  TextFormField phoneFormField() {
    return TextFormField(
      decoration: const InputDecoration(
          labelText: "Phone", suffixIcon: Icon(Icons.phone)),
      controller: _phoneController,
      keyboardType: TextInputType.phone,
      validator: (value) {
        if (value == null) {
          return "Phone is required.";
        }
        return null;
      },
    );
  }
}
