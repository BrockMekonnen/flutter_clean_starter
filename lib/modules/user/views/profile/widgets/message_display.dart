import 'package:flutter/cupertino.dart';

class MessageDisplay extends StatelessWidget {
  const MessageDisplay({required this.message, Key? key}): super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3,
      child: Center(
        child: SingleChildScrollView(
          child: Text(
            message,
            style: const TextStyle(fontSize: 25),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

}