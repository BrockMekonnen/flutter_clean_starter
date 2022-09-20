// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteUser _$RemoteUserFromJson(Map<String, dynamic> json) => RemoteUser(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      roles: (json['roles'] as List<dynamic>).map((e) => e as String).toList(),
      isEmailVerified: json['isEmailVerified'] as bool,
    );

Map<String, dynamic> _$RemoteUserToJson(RemoteUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'phone': instance.phone,
      'email': instance.email,
      'roles': instance.roles,
      'isEmailVerified': instance.isEmailVerified,
    };
