import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../layout/adaptive_layout/adaptive_destination.dart';

enum NavTab { none, home, posts, profile, settings }

List<AdaptiveDestination> getNavItems(BuildContext context) {
  return <AdaptiveDestination>[
    AdaptiveDestination(
      title: context.tr('layoutPage.home'),
      icon: Icons.home,
      route: '/home',
      navTab: NavTab.home,
    ),
    AdaptiveDestination(
      title: "Posts",
      icon: Icons.article,
      route: '/posts',
      navTab: NavTab.posts,
    ),
    AdaptiveDestination(
      title: context.tr('layoutPage.profile'),
      icon: Icons.person,
      route: '/profile',
      navTab: NavTab.profile,
    ),
    AdaptiveDestination(
      title: context.tr('layoutPage.settings'),
      icon: Icons.settings,
      route: '/settings',
      navTab: NavTab.settings,
    ),
  ];
}
