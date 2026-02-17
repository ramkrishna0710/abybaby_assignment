
import 'package:assignment_abybaby/data/model/auth/user_model.dart';

class LoginResponseModel {
  final UserModel user;
  final String accessToken;

  LoginResponseModel({
    required this.user,
    required this.accessToken,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      user: UserModel.fromJson(json['user']),
      accessToken: json['access_token'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "user": user.toJson(),
      "access_token": accessToken,
    };
  }
}
