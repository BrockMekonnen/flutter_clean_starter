// ignore_for_file: overridden_fields

import 'package:clean_starter/modules/post/data/models/post_list_item_model.dart';
import 'package:clean_starter/modules/post/domain/post.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_model.g.dart';

@JsonSerializable(createToJson: false)
class PostModel extends Post {
  @override
  final PosterModel user;

  @override
  @JsonKey(defaultValue: [])
  final List<PostCommentModel> comments;

  PostModel(
    String id,
    String title,
    String content,
    String state,
    DateTime? postedAt,
    DateTime createdAt,
    DateTime updatedAt,
    this.user,
    this.comments,
  ) : super(id, title, content, state, postedAt, createdAt, updatedAt, user, comments);

  factory PostModel.fromJson(Map<String, dynamic> json) => _$PostModelFromJson(json);
}

@JsonSerializable(createToJson: false)
class PostCommentModel extends PostComment {
  PostCommentModel(
    super.id,
    super.body,
    super.createdAt,
  );

  factory PostCommentModel.fromJson(Map<String, dynamic> json) =>
      _$PostCommentModelFromJson(json);
}
