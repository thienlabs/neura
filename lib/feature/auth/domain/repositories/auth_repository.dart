import 'package:neura/feature/auth/domain/entities/user.dart';

abstract class AuthRepository {
   Future<User> register(String name, String email, String password);
   Future<User> login(String email, String password);
}