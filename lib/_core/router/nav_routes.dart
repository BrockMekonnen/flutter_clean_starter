import 'router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void navRoutes(int index, BuildContext context) {
  switch (index) {
    case 0:
      context.goNamed(homeRouteName);
      break;
    case 1:
      context.goNamed(listUserRouteName);
      break;
    case 2:
      context.goNamed(addUserRouteName);
      break;
    case 3:
      context.goNamed(walletRouteName);
      break;
    default:
  }
}

int calculateSelectedIndex(BuildContext context) {
  final GoRouter route = GoRouter.of(context);
  final String location = route.location;

  if (location == '/home') {
    return 0;
  }
  if (location == '/users') {
    return 1;
  }
  if (location == '/add-user') {
    return 2;
  }
  if (location == '/wallet') {
    return 3;
  }

  return 0;
}
