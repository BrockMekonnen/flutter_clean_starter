import 'package:json_annotation/json_annotation.dart';

import '../../domain/cqrs.dart';

part 'result_page_model.g.dart';

@JsonSerializable(createToJson: false)
class ResultPageModel extends ResultPage {
  ResultPageModel(
    super.current,
    super.pageSize,
    super.totalPages,
    super.totalElements,
    super.first,
    super.last,
  );

  factory ResultPageModel.fromJson(Map<String, dynamic> json) =>
      _$ResultPageModelFromJson(json);
}
