// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_list_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostListItemModel _$PostListItemModelFromJson(Map<String, dynamic> json) =>
    PostListItemModel(
      json['id'] as String,
      json['title'] as String,
      json['content'] as String,
      json['state'] as String,
      json['postedAt'] == null
          ? null
          : DateTime.parse(json['postedAt'] as String),
      PosterModel.fromJson(json['user'] as Map<String, dynamic>),
    );

PosterModel _$PosterModelFromJson(Map<String, dynamic> json) => PosterModel(
      json['id'] as String,
      json['firstName'] as String,
      json['lastName'] as String,
    );
