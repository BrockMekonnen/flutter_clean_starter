import 'package:flutter/material.dart';

class SideDrawerHeader extends StatelessWidget {
  const SideDrawerHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: SizedBox(
        height: 57,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 10),
            const FlutterLogo(size: 40),
            const SizedBox(width: 20),
            Text(
              'Clean Arc',
              style: TextStyle(
                  fontSize: 18, color: Theme.of(context).primaryColor),
            ),
            const SizedBox(width: 20),
          ],
        ),
      ),
    );
  }
}
