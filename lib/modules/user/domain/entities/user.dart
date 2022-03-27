import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String gender;
  final List<String> roles;
  final String avatar;

  const User(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.phone,
      required this.email,
      required this.roles,
      required this.gender,
      required this.avatar});

  const User.empty({
    this.id = '',
    this.firstName = '',
    this.lastName = '',
    this.phone = '',
    this.email = '',
    this.gender = '',
    this.roles = const [],
    this.avatar = '',
  });

  @override
  List<Object?> get props =>
      [id, firstName, lastName, phone, email, roles, avatar];
}
