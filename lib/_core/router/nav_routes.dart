import 'package:clean_flutter/_core/router/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../_shared/layout/utils/nav_items.dart';

void navRoutes(int index, BuildContext context) {
  switch (NavigationTab.values[index]) {
    case NavigationTab.home:
      context.goNamed(homeRouteName);
      break;
    case NavigationTab.addUser:
      context.goNamed(addUserRouteName);
      break;
    case NavigationTab.users:
      context.goNamed(listUserRouteName);
      break;
    case NavigationTab.wallet:
      context.goNamed(walletRouteName);
      break;
    default:
  }
}
