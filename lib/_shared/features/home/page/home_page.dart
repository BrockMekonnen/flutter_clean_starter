import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../_core/layout/page_layout.dart';
import '../../../../modules/auth/bloc/auth_bloc.dart';
import '../../../shared_routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return PageLayout(
      title: context.tr('homePage.title'),
      pageTab: SharedNavTab.home,
      page: Align(
        alignment: Alignment.topCenter,
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
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
                      const SizedBox(height: 15),
                      Text(
                        '${context.tr('homePage.hello')}, ${state.user.firstName}! 👋',
                        style: theme.textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 12),
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: theme.primaryColor.withValues(alpha: 0.2),
                        child: Icon(Icons.person, size: 60, color: theme.primaryColor),
                      ),
                      const SizedBox(height: 35),
                      Text(
                        '${state.user.firstName} ${state.user.lastName}',
                        style: theme.textTheme.headlineMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text('ID: ${state.user.id}',
                          style: theme.textTheme.bodyMedium
                              ?.copyWith(color: Colors.grey[700])),
                      const SizedBox(height: 34),
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
}
