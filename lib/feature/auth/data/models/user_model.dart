import 'package:neura/feature/auth/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required String id,
    required String name,
    required String email,
    required String token,
  }) : super(id: id, name: name, email: email, token: token);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final userJson = json['user'] ?? json; 
    return UserModel(
      id: userJson['_id'] ?? '',
      name: userJson['name'] ?? 'Unknown User',
      email: userJson['email'] ?? '',
      token: json['token'] ?? '',
    );
  }
}
