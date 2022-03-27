import '../../domain/entities/user.dart';
import '../hive/user_model.dart';

class TokenMapper {
  static String fromJson(Map<String, dynamic> json) {
    return json['data']['token'];
  }
}

class UserMapper {
  static UserModel toModel(User user) {
    UserModel userModel = UserModel(
      id: user.id,
      firstName: user.firstName,
      lastName: user.lastName,
      phone: user.phone,
      email: user.email,
      gender: user.gender,
      roles: user.roles,
      avatar: user.avatar,
    );
    return userModel;
  }

  static User toEntity(UserModel userModel) {
    User user = User(
      id: userModel.id,
      firstName: userModel.firstName,
      lastName: userModel.lastName,
      phone: userModel.phone,
      email: userModel.email,
      roles: userModel.roles,
      gender: userModel.gender,
      avatar: userModel.avatar,
    );
    return user;
  }

  static UserModel fromJosn(Map<String, dynamic> json) {
    List<String> roles = [];
    print(json['data']['id']);
    json['data']['roles'].forEach((temp) => {roles.add(temp)});
    return UserModel(
      id: json['data']['id'].toString(),
      firstName: json['data']['firstName'].toString(),
      lastName: json['data']['lastName'].toString(),
      phone: json['data']['phone'].toString(),
      email: json['data']['email'].toString(),
      gender: json['data']['gender'].toString(),
      roles: roles,
      avatar: json['data']['avatar'].toString(),
    );
  }
}
