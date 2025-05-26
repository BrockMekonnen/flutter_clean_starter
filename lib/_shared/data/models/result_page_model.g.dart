// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result_page_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResultPageModel _$ResultPageModelFromJson(Map<String, dynamic> json) =>
    ResultPageModel(
      (json['current'] as num).toInt(),
      (json['pageSize'] as num).toInt(),
      (json['totalPages'] as num).toInt(),
      (json['totalElements'] as num).toInt(),
      json['first'] as bool,
      json['last'] as bool,
    );
