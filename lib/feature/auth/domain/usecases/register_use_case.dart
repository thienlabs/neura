import 'package:neura/feature/auth/domain/entities/user.dart';
import 'package:neura/feature/auth/domain/repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;
  RegisterUseCase({required this.repository});
 Future<User> call(String name, String email, String password) {
    return repository.register(name, email, password);
  }
}
