// ignore_for_file: overridden_fields

import 'package:clean_starter/modules/post/domain/post_list_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_list_item_model.g.dart';

@JsonSerializable(createToJson: false)
class PostListItemModel extends PostListItem {
  @override
  final PosterModel user;

  PostListItemModel(
    String id,
    String title,
    String content,
    String state,
    DateTime? postedAt,
    this.user,
  ) : super(
          id,
          title,
          content,
          state,
          postedAt,
          user,
        );

  factory PostListItemModel.fromJson(Map<String, dynamic> json) =>
      _$PostListItemModelFromJson(json);
}

@JsonSerializable(createToJson: false)
class PosterModel extends Poster {
  PosterModel(
    super.id,
    super.firstName,
    super.lastName,
  );

  factory PosterModel.fromJson(Map<String, dynamic> json) => _$PosterModelFromJson(json);
}
