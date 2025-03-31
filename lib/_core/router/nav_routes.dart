import 'package:flutter/material.dart';

import '../layout/adaptive_layout/adaptive_destination.dart';

enum NavTab { none, home, profile }

final navItems = <AdaptiveDestination>[
  AdaptiveDestination(
    title: 'Home',
    icon: Icons.home,
    route: '/home',
    navTab: NavTab.home,
  ),
  AdaptiveDestination(
    title: 'Profile',
    icon: Icons.person,
    route: '/profile',
    navTab: NavTab.profile,
  ),
];
