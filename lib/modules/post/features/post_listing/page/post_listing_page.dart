import 'package:clean_starter/modules/post/domain/post_list_item.dart';
import 'package:clean_starter/modules/post/features/post_listing/bloc/post_listing_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../_core/di.dart';
import '../../../../../_core/layout/page_layout.dart';
import '../../../../../_core/router/nav_routes.dart';

class PostListingPage extends StatelessWidget {
  const PostListingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      title: "Posts",
      pageTab: NavTab.posts,
      page: BlocProvider<PostListingBloc>(
        create: (context) => di(),
        child: PostListingBody(),
      ),
    );
  }
}

class PostListingBody extends StatefulWidget {
  const PostListingBody({super.key});

  @override
  State<PostListingBody> createState() => _PostListingBodyState();
}

class _PostListingBodyState extends State<PostListingBody> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostListingBloc, PostListingState>(
      builder: (context, state) {
        return PagedListView<>(
          state: state,
          fetchNextPage: fetchNextPage,
          builderDelegate: builderDelegate,
        );
      },
    );
  }
}
