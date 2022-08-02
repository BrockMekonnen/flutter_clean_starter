import 'package:clean_flutter/_shared/layout/navigation/adaptive_navigation.dart';
import 'package:flutter/material.dart';

class LayoutPage extends StatelessWidget {
  const LayoutPage({
    Key? key,
    required this.page,
  }) : super(key: key);

  final Widget page;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AdaptiveNavigation(
        // appBar: AppBar(),
        body: page,
        selectedIndex: 0,
        destinations: <AdaptiveDestination>[
          AdaptiveDestination(
            title: 'Jobs',
            icon: Icons.work,
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
        ],
      ),
    );
  }
}
