// ignore_for_file: overridden_fields

import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/user.dart';

part 'user_model.g.dart';

@HiveType(typeId: 1)
@JsonSerializable(createToJson: false)
class UserModel extends User {
  @override
  @HiveField(0)
  @JsonKey(name: 'id')
  final String id;

  @override
  @HiveField(1)
  @JsonKey(name: 'firstName')
  final String firstName;

  @override
  @HiveField(2)
  @JsonKey(name: 'lastName')
  final String lastName;

  @override
  @HiveField(3)
  @JsonKey(name: 'phone')
  final String phone;

  @override
  @HiveField(4)
  @JsonKey(name: 'email')
  final String email;

  @override
  @HiveField(5)
  @JsonKey(name: 'isEmailVerified', defaultValue: false)
  final bool isEmailVerified;

  @override
  @HiveField(6)
  @JsonKey(name: 'roles')
  final List<String> roles;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  const UserModel(this.id, this.firstName, this.lastName, this.phone, this.email,
      this.isEmailVerified, this.roles)
      : super(
          id: id,
          firstName: firstName,
          lastName: lastName,
          phone: phone,
          email: email,
          isEmailVerified: isEmailVerified,
          roles: roles,
        );
}
