import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel extends Equatable {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String firstName;

  @HiveField(2)
  final String lastName;

  @HiveField(3)
  final String phone;

  @HiveField(4)
  final String email;

  @HiveField(5)
  final String gender;

  @HiveField(6)
  final List<String> roles;

  @HiveField(7)
  final String avatar;

  const UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.gender,
    required this.roles,
    required this.avatar,
  });

  @override
  List<Object?> get props =>
      [id, firstName, lastName, phone, email, roles, gender, avatar];
}
