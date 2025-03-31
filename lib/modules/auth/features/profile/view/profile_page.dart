import 'package:flutter/material.dart';

import '../../../../../_core/layout/page_layout.dart';
import '../../../../../_core/router/nav_routes.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      title: 'Profile',
      pageTab: NavTab.profile,
      page: Center(
        child: Text('Profile Page'),
      ),
    );
  }
}
