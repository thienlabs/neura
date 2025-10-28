import 'package:neura/feature/auth/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required String id,
    required String name,
    required String email,
    required String token,
    required String image
  }) : super(id: id, name: name, email: email, token: token,image: image);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final userJson = json['user'] ?? json; 
    return UserModel(
      id: userJson['_id'] ?? '',
      name: userJson['name'] ?? 'Unknown User',
      email: userJson['email'] ?? '',
      image: userJson['image']??'https://www.gravatar.com/avatar/?d=mp',
      token: json['token'] ?? '',
    );
  }
}
