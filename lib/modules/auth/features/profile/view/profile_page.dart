import 'package:clean_flutter/_core/layout/layout_page.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      page: Scaffold(
        body: Center(
          child: Text('Profile Page'),
        ),
      ),
    );
  }
}
