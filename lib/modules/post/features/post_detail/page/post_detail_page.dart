import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../_core/di.dart';
import '../../../../../_core/layout/page_layout.dart';
import '../../../domain/post.dart';
import '../../../post_routes.dart';
import '../cubit/post_detail_cubit.dart';

class PostDetailPage extends StatelessWidget {
  const PostDetailPage({
    super.key,
    required this.postId,
    required this.navTab,
  });

  final String postId;
  final PostNavTab navTab;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di<PostDetailCubit>()..getPost(postId),
      child: PageLayout(
        title: context.tr('postPage.postDetails'),
        navTab: navTab,
        hideNavBarOnMobile: true,
        page: BlocBuilder<PostDetailCubit, PostDetailState>(
          builder: (context, state) {
            if (state is PostDetailFailure) {
              return Center(child: Text(state.message));
            } else if (state is PostDetailSuccess) {
              return PostDetailBody(post: state.post);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}

class PostDetailBody extends StatelessWidget {
  const PostDetailBody({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    final formattedPostedAt = post.postedAt != null
        ? DateFormat.yMMMMd().add_jm().format(post.postedAt!)
        : "Not posted yet";

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),

              /// Post title
              Text(
                post.title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),

              /// Post metadata
              Row(
                children: [
                  Icon(Icons.person, size: 16, color: Colors.grey.shade600),
                  const SizedBox(width: 4),
                  Text(
                    "${post.user.firstName} ${post.user.lastName}",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey.shade700,
                        ),
                  ),
                  const SizedBox(width: 12),
                  Icon(Icons.access_time, size: 16, color: Colors.grey.shade600),
                  const SizedBox(width: 4),
                  Text(
                    formattedPostedAt,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey.shade700,
                        ),
                  ),
                  const SizedBox(width: 12),
                  _StateBadge(state: post.state),
                ],
              ),

              const Divider(height: 42),

              /// Post content
              Text(
                post.content,
                style: Theme.of(context).textTheme.bodyLarge,
              ),

              const SizedBox(height: 42),

              /// Comments
              Text(
                "Comments",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 12),

              if (post.comments.isEmpty)
                Text(
                  "No comments yet.",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontStyle: FontStyle.italic,
                        color: Colors.grey,
                      ),
                )
              else
                ...post.comments.map(
                  (comment) => Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(comment.body),
                          const SizedBox(height: 8),
                          Text(
                            comment.createdAt != null
                                ? DateFormat.yMMMd().add_jm().format(comment.createdAt!)
                                : "Unknown date",
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  color: Colors.grey,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StateBadge extends StatelessWidget {
  const _StateBadge({required this.state});

  final String state;

  Color get _color {
    switch (state.toLowerCase()) {
      case 'published':
        return Colors.green;
      case 'draft':
        return Colors.orange;
      case 'archived':
        return Colors.grey;
      default:
        return Colors.blueGrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        state.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: _color,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
