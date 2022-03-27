import 'package:flutter/material.dart';

import '../../../domain/entities/user.dart';

class ProfileDisplay extends StatelessWidget {
  final User user;

  const ProfileDisplay({required this.user, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: const Text('Profile'),
          subtitle: Text(
            'Secondary Text',
            style: TextStyle(color: Colors.black.withOpacity(0.6)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            user.firstName + " " + user.lastName,
            style: TextStyle(color: Colors.black.withOpacity(0.6)),
          ),
        ),
      ],
    );
  }
}
