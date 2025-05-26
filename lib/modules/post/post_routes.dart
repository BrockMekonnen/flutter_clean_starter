import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../_core/layout/adaptive_layout/adaptive_destination.dart';
import '../../_core/app_router.dart';
import 'features/post_listing/page/post_listing_page.dart';

enum PostNavTab implements NavTab { none, posts, myPosts }

List<AdaptiveDestination> getPostNavTabs(BuildContext context) {
  return <AdaptiveDestination>[
    AdaptiveDestination(
      title: "Posts",
      icon: Icons.article,
      route: '/posts',
      navTab: PostNavTab.posts,
      order: 2,
    ),
  ];
}

List<GoRoute> postRoutes() {
  return [
    GoRoute(
      path: "/posts",
      redirect: authRouteGuard,
      pageBuilder: (context, state) => FadeTransitionPage(
        key: fadeTransitionKey,
        child: const PostListingPage(),
      ),
    ),
  ];
}
