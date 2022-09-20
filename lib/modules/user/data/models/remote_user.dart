// ignore_for_file: overridden_fields

import 'package:json_annotation/json_annotation.dart';

import '../../domain/user.dart';

part 'remote_user.g.dart';

@JsonSerializable()
class RemoteUser extends User {
  const RemoteUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.roles,
    required this.isEmailVerified,
  }) : super(
          id: id,
          firstName: firstName,
          lastName: lastName,
          phone: phone,
          email: email,
          roles: roles,
          isEmailVerified: isEmailVerified,
        );

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

  @override
  @JsonKey(name: 'isEmailVerified')
  final bool isEmailVerified;

  factory RemoteUser.fromJson(Map<String, dynamic> json) =>
      _$RemoteUserFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteUserToJson(this);
}
