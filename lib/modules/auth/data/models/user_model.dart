// ignore_for_file: overridden_fields

import 'package:json_annotation/json_annotation.dart';

import '../../domain/user.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends User {
  @override
  @JsonKey(name: 'id')
  final String id;

  @override
  @JsonKey(name: 'firstName')
  final String firstName;

  @override
  @JsonKey(name: 'lastName')
  final String lastName;

  @override
  @JsonKey(name: 'phone')
  final String phone;

  @override
  @JsonKey(name: 'email')
  final String email;

  @override
  @JsonKey(name: 'roles')
  final List<String> roles;

  const UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.roles,
  }) : super(
          id: id,
          firstName: firstName,
          lastName: lastName,
          phone: phone,
          email: email,
          roles: roles,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
