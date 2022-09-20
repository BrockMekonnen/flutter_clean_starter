import 'package:clean_flutter/modules/user/domain/user.dart';
import 'package:flutter/material.dart';

class UserListItem extends StatelessWidget {
  final User user;

  const UserListItem({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Wrap(
        spacing: 10,
        children: [
          Icon(
            Icons.person,
            size: 100,
            color: Theme.of(context).primaryColor,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text('${user.firstName} ${user.lastName}'),
              const SizedBox(height: 5),
              Text(user.email),
              const SizedBox(height: 5),
              Text(user.phone),
              const SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }
}
