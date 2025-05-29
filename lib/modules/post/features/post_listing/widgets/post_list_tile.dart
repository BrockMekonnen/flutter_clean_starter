import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../domain/post_list_item.dart';

class PostListTile extends StatelessWidget {
  const PostListTile({
    super.key,
    required this.item,
    required this.isMyPosts,
    this.onEdit,
    this.onPublish,
    this.onDelete,
    this.onTap,
  });

  final PostListItem item;
  final bool isMyPosts;
  final VoidCallback? onEdit;
  final VoidCallback? onPublish;
  final VoidCallback? onDelete;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final formattedDate = item.postedAt != null
        ? DateFormat.yMMMd().add_jm().format(item.postedAt!)
        : 'Not posted';

    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 3,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Title
                  Text(
                    item.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),

                  /// Content snippet
                  Text(
                    item.content,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 12),

                  /// Metadata row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// Posted by
                      if (!isMyPosts)
                        Row(
                          children: [
                            const Icon(Icons.person, size: 16, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(
                              "${item.user.firstName} ${item.user.lastName}",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        )
                      else
                        const SizedBox(),

                      /// Date and State
                      Row(
                        children: [
                          Text(
                            formattedDate,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: Colors.grey),
                          ),
                          if (isMyPosts) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: _getStateColor(item.state).withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                item.state.toUpperCase(),
                                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                      color: _getStateColor(item.state),
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          ]
                        ],
                      ),
                    ],
                  ),

                  /// Action buttons (Edit/Delete)
                  if (isMyPosts) ...[
                    const Divider(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (item.state == "DRAFT") ...[
                          TextButton.icon(
                            onPressed: onPublish,
                            icon: const Icon(Icons.upload_rounded, size: 18),
                            label: Text(context.tr('postPage.publish')),
                          ),
                          const SizedBox(width: 8),
                          TextButton.icon(
                            onPressed: onEdit,
                            icon: const Icon(Icons.edit, size: 18),
                            label: Text(context.tr('postPage.edit')),
                          ),
                          const SizedBox(width: 8),
                        ],
                        TextButton.icon(
                          onPressed: onDelete,
                          icon: const Icon(Icons.delete_outline, size: 18),
                          label: Text(context.tr('postPage.delete')),
                          style: TextButton.styleFrom(foregroundColor: Colors.red),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _getStateColor(String state) {
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
}
