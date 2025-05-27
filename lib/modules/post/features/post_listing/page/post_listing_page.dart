import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../_core/di.dart';
import '../../../../../_core/layout/adaptive_layout/adaptive_destination.dart';
import '../../../../../_core/layout/page_layout.dart';
import '../../../../../_shared/widgets/show_loading_overlay.dart';
import '../../../../../_shared/widgets/show_toast_notification.dart';
import '../../../domain/post_list_item.dart';
import '../../../post_routes.dart';
import '../bloc/post_listing_bloc.dart';
import '../cubit/delete_post_cubit.dart';
import '../cubit/publish_post_cubit.dart';
import '../widgets/post_list_tile.dart';

class PostListingPage extends StatelessWidget {
  const PostListingPage({
    super.key,
    required this.navTab,
  });

  final NavTab navTab;

  @override
  Widget build(BuildContext context) {
    bool isMyPosts = navTab == PostNavTab.myPosts;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di<DeletePostCubit>()),
        BlocProvider(create: (context) => di<PublishPostCubit>()),
      ],
      child: PageLayout(
        title: isMyPosts ? context.tr('postPage.title2') : context.tr('postPage.title1'),
        navTab: navTab,
        page: PostListingBody(isMyPosts: isMyPosts),
        floatingActionButton: isMyPosts
            ? FloatingActionButton(
                onPressed: () {
                  String current = GoRouter.of(context).state.matchedLocation;
                  String to = "$current/new";
                  context.go(to);
                },
                child: Icon(Icons.add),
              )
            : null,
      ),
    );
  }
}

class PostListingBody extends StatefulWidget {
  const PostListingBody({super.key, required this.isMyPosts});

  final bool isMyPosts;

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
    context
        .read<PostListingBloc>()
        .add(RefreshPostListingEvent(isMyPosts: widget.isMyPosts));
    await bloc;
  }

  void goToDetails(String id) {
    String current = GoRouter.of(context).state.matchedLocation;
    String to = "$current/detail/$id";
    context.go(to);
  }

  void goToEdit(String id) {
    String current = GoRouter.of(context).state.matchedLocation;
    String to = "$current/edit/$id";
    context.go(to);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<DeletePostCubit, DeletePostState>(
          listener: (context, state) {
            if (state is DeletePostLoading) {
              LoadingOverlay.show();
            } else if (state is DeletePostSuccess) {
              LoadingOverlay.hide();
              CustomToast.showSuccessNotification(
                  title: "Delete Successful",
                  description: "Post with ID //${state.postId} has been deleted!");
              context
                  .read<PostListingBloc>()
                  .add(DeletePostFromListingEvent(state.postId));
            } else if (state is DeletePostFailure) {
              LoadingOverlay.hide();
              CustomToast.showErrorNotification(
                  title: "Delete Failed", description: state.message);
            }
          },
        ),
        BlocListener<PublishPostCubit, PublishPostState>(
          listener: (context, state) {
            if (state is PublishPostLoading) {
              LoadingOverlay.show();
            } else if (state is PublishPostFailure) {
              LoadingOverlay.hide();
              CustomToast.showErrorNotification(
                  title: "Publishing Failed", description: state.message);
            } else if (state is PublishPostSuccess) {
              LoadingOverlay.hide();
              CustomToast.showSuccessNotification(
                  title: "Success",
                  description: "Post with ID ${state.post.id} has been Published!");
              context.read<PostListingBloc>().add(UpdatePostInListingEvent(state.post));
            }
          },
        ),
      ],
      child: BlocBuilder<PostListingBloc, PagingState<int, PostListItem>>(
        builder: (context, state) => RefreshIndicator(
          onRefresh: _refresh,
          child: PagedListView<int, PostListItem>(
            state: state,
            fetchNextPage: () => context
                .read<PostListingBloc>()
                .add(FetchPostListingEvent(isMyPosts: widget.isMyPosts)),
            builderDelegate: PagedChildBuilderDelegate(
              itemBuilder: (context, item, index) => PostListTile(
                item: item,
                isMyPosts: widget.isMyPosts,
                onTap: () => goToDetails(item.id),
                onEdit: () => goToEdit(item.id),
                onPublish: () => context.read<PublishPostCubit>().publish(item.id),
                onDelete: () => context.read<DeletePostCubit>().onDelete(item.id),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
