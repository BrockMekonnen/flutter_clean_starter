import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
