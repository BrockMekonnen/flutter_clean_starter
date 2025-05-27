import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../_core/layout/page_layout.dart';
import '../../../auth_routes.dart';
import '../../../bloc/auth_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return PageLayout(
      title: context.tr('profilePage.title'),
      navTab: AuthNavTab.profile,
      page: Align(
        alignment: Alignment.topCenter,
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            final user = state.user;
            return Card(
              elevation: 1,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: SizedBox(
                width: 700,
                height: 400,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: theme.primaryColor.withValues(alpha: 0.1),
                        child: Icon(Icons.person, size: 60, color: theme.primaryColor),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        '${user.firstName} ${user.lastName}',
                        style: theme.textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      Text('User ID: ${user.id}', style: theme.textTheme.bodySmall),
                      const SizedBox(height: 8),
                      const Divider(height: 30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _infoRow(Icons.email, user.email, theme.primaryColor),
                          const SizedBox(height: 12),
                          _infoRow(Icons.phone, user.phone, theme.primaryColor),
                        ],
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String value, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 25, color: color),
        const SizedBox(width: 20),
        Text(
          value,
          style: const TextStyle(fontSize: 16),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
