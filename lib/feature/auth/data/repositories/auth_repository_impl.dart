import 'package:neura/feature/auth/data/datasources/auth_remote_data_source.dart';
import 'package:neura/feature/auth/domain/entities/user.dart';
import 'package:neura/feature/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({required this.authRemoteDataSource});

  @override
  Future<User> login(String email, String password) async {
    return authRemoteDataSource.login(email: email, password: password);
  }

  @override
  Future<User> register(String name, String email, String password) async {
    return authRemoteDataSource.register(
      username: name,
      email: email,
      password: password,
    );
  }
}
