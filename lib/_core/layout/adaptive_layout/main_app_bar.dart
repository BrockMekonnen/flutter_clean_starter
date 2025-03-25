import 'package:flutter/material.dart';

class MainAppBar extends AppBar implements PreferredSizeWidget {
  MainAppBar({
    Key? key,
    required BuildContext context,
    // required String title,
  }) : super(
          key: key,
          elevation: 2,
          // title: Text(
          //   title,
          //   style: const TextStyle(fontSize: 18),
          // ),
        );
}
