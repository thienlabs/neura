

import 'package:neura/feature/auth/data/models/user_model.dart';
import 'package:dio/dio.dart' as dio;
class AuthRemoteDataSource {
  final String baseUrl = "https://neura-be.onrender.com";

  Future<UserModel> register({required String name, required String email, required String password}) async {
    final client = dio.Dio();
    final response = await client.post(
      '${baseUrl}/auth/register',
      data: {
        'name': name,
        'email': email,
        'password': password,
      },
    );
      final data = response.data;
    print(response.data);
   return UserModel.fromJson(data['user']);
  }
  
  Future<UserModel> login({
  required String email,
  required String password,
}) async {
  final client = dio.Dio();
  final response = await client.post(
    '$baseUrl/auth/login',
    data: {
      'email': email,
      'password': password,
    },
  );

  final data = response.data;
  print('Login response: $data');

  return UserModel.fromJson(data);
}

}
