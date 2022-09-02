import 'package:adaptive_layout/adaptive_layout.dart';
import 'package:flutter/material.dart';

enum NavigationTab {
  home,
  bids,
  alerts,
  wallet,
}

final navItems = <AdaptiveDestination>[
  AdaptiveDestination(
    title: 'Home',
    icon: Icons.home,
  ),
  AdaptiveDestination(
    title: 'Bids',
    icon: Icons.handshake,
  ),
  AdaptiveDestination(
    title: 'Alerts',
    icon: Icons.notifications,
  ),
  AdaptiveDestination(
    title: 'Wallet',
    icon: Icons.account_balance_wallet,
  ),
];
