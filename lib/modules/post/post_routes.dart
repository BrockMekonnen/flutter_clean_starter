import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../_core/app_router.dart';
import '../../_core/di.dart';
import '../../_core/layout/adaptive_layout/adaptive_destination.dart';
import 'features/post_detail/page/post_detail_page.dart';
import 'features/post_edit/page/create_post_page.dart';
import 'features/post_edit/page/edit_post_page.dart';
import 'features/post_listing/bloc/post_listing_bloc.dart';
import 'features/post_listing/page/post_listing_page.dart';

enum PostNavTab implements NavTab { none, posts, myPosts }

List<AdaptiveDestination> getPostNavTabs(BuildContext context) {
  return <AdaptiveDestination>[
    AdaptiveDestination(
      title: context.tr('postPage.title1'),
      icon: Icons.article,
      route: '/posts',
      navTab: PostNavTab.posts,
      order: 20,
    ),
    AdaptiveDestination(
      title: context.tr('postPage.title2'),
      icon: Icons.note_alt,
      route: '/me/posts',
      navTab: PostNavTab.myPosts,
      order: 20,
    ),
  ];
}

List<RouteBase> postRoutes() {
  return [
    ShellRoute(
      pageBuilder: (context, state, child) => FadeTransitionPage(
        key: state.pageKey,
        child: BlocProvider(
          create: (_) => di<PostListingBloc>(),
          child: child,
        ),
      ),
      routes: [
        GoRoute(
          path: "/posts",
          redirect: authRouteGuard,
          pageBuilder: (context, state) => FadeTransitionPage(
            key: state.pageKey,
            child: PostListingPage(navTab: PostNavTab.posts),
          ),
          routes: [
            GoRoute(
              path: "detail/:id",
              redirect: authRouteGuard,
              pageBuilder: (context, state) => FadeTransitionPage(
                child: PostDetailPage(
                  postId: state.pathParameters['id']!,
                  navTab: PostNavTab.posts,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
    ShellRoute(
      pageBuilder: (_, __, child) => FadeTransitionPage(
        child: BlocProvider(
          create: (_) => di<PostListingBloc>(),
          child: child,
        ),
      ),
      routes: [
        GoRoute(
          path: "/me/posts",
          redirect: authRouteGuard,
          pageBuilder: (context, state) => FadeTransitionPage(
            key: state.pageKey,
            child: const PostListingPage(navTab: PostNavTab.myPosts),
          ),
          routes: [
            GoRoute(
              path: "detail/:id",
              redirect: authRouteGuard,
              pageBuilder: (context, state) => FadeTransitionPage(
                child: PostDetailPage(
                  postId: state.pathParameters['id']!,
                  navTab: PostNavTab.myPosts,
                ),
              ),
            ),
            GoRoute(
              path: "edit/:id",
              redirect: authRouteGuard,
              pageBuilder: (context, state) => FadeTransitionPage(
                child: EditPostPage(
                  postId: state.pathParameters['id']!,
                ),
              ),
            ),
            GoRoute(
              path: "new",
              redirect: authRouteGuard,
              pageBuilder: (context, state) => FadeTransitionPage(
                child: CreatePostPage(),
              ),
            ),
          ],
        ),
      ],
    ),
  ];
}
