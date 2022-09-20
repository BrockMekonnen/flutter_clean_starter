import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;

  final String firstName;

  final String lastName;

  final String phone;

  final String email;

  final List<String> roles;

  final bool isEmailVerified;

  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.roles,
    required this.isEmailVerified,
  });

  static const empty = User(
    id: '-',
    firstName: '-',
    lastName: '-',
    phone: '-',
    email: '-',
    isEmailVerified: false,
    roles: [],
  );

  @override
  List<Object> get props => [
        id,
        firstName,
        lastName,
        phone,
        email,
        roles,
      ];
}
