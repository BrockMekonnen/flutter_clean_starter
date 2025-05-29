// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostModel _$PostModelFromJson(Map<String, dynamic> json) => PostModel(
      json['id'] as String,
      json['title'] as String,
      json['content'] as String,
      json['state'] as String,
      json['postedAt'] == null
          ? null
          : DateTime.parse(json['postedAt'] as String),
      DateTime.parse(json['createdAt'] as String),
      DateTime.parse(json['updatedAt'] as String),
      PosterModel.fromJson(json['user'] as Map<String, dynamic>),
      (json['comments'] as List<dynamic>?)
              ?.map((e) => PostCommentModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

PostCommentModel _$PostCommentModelFromJson(Map<String, dynamic> json) =>
    PostCommentModel(
      json['id'] as String,
      json['body'] as String,
      json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );
