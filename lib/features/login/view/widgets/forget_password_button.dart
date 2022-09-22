import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../_core/router/router.dart';

class ForgetPasswordButton extends StatelessWidget {
  const ForgetPasswordButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {
            context.goNamed(forgetPasswordRouteName);
          },
          child: const Text("Forget Password?"),
        ),
      ],
    );
  }
}
