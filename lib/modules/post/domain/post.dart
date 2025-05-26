import 'package:clean_starter/modules/post/domain/post_list_item.dart';

class Post {
  final String id;
  final String title;
  final String content;
  final String state;
  final DateTime? postedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Poster user;
  final List<PostComment> comments;

  Post(
    this.id,
    this.title,
    this.content,
    this.state,
    this.postedAt,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.comments,
  );
}

class PostComment {
  final String id;
  final String body;
  final DateTime? createdAt;

  PostComment(
    this.id,
    this.body,
    this.createdAt,
  );
}
