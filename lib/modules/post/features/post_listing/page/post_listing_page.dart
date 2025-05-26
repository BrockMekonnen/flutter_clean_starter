import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../_core/di.dart';
import '../../../../../_core/layout/page_layout.dart';
import '../../../domain/post_list_item.dart';
import '../../../post_routes.dart';
import '../bloc/post_listing_bloc.dart';
import '../widgets/post_list_tile.dart';

class PostListingPage extends StatelessWidget {
  const PostListingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PostListingBloc>(
      create: (context) => di(),
      child: PageLayout(
        title: "Posts",
        pageTab: PostNavTab.posts,
        page: PostListingBody(),
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

  Future<void> _refresh() async {
    Future bloc =
        context.read<PostListingBloc>().stream.firstWhere((val) => !val.isLoading);
    context.read<PostListingBloc>().add(RefreshPostListingEvent());
    await bloc;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostListingBloc, PagingState<int, PostListItem>>(
      builder: (context, state) => RefreshIndicator(
        onRefresh: _refresh,
        child: PagedListView<int, PostListItem>(
          state: state,
          fetchNextPage: () =>
              context.read<PostListingBloc>().add(FetchPostListingEvent()),
          builderDelegate: PagedChildBuilderDelegate(
            itemBuilder: (context, item, index) => PostListTile(item: item),
          ),
        ),
      ),
    );
  }
}
