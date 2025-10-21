import 'package:neura/feature/auth/domain/entities/user.dart';

class UserModel extends User {
  UserModel({required id, required name, required email, required token})
    : super(id: id, name: name, email: email, token: token);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final userJson = json['user'] ?? {}; // tránh null
    return UserModel(
      id: userJson['id'] ?? '',
      name: userJson['name'] ?? 'Unknown User',
      email: userJson['email'] ?? '',
      token: json['token'] ?? '',
    );
  }
}
