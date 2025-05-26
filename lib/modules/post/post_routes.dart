import 'package:clean_starter/_core/router/app_router.dart';
import 'package:clean_starter/modules/post/features/post_listing/page/post_listing_page.dart';
import 'package:go_router/go_router.dart';

List<GoRoute> postRoutes() {
  return [
    GoRoute(
      path: "/posts",
      pageBuilder: (context, state) => FadeTransitionPage(
        key: fadeTransitionKey,
        child: const PostListingPage(),
      ),
    ),
  ];
}
