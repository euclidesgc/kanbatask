import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository _repository;

  RegisterUseCase(this._repository);

  Future<UserEntity> call({
    required String email,
    required String password,
    String? displayName,
  }) async {
    return await _repository.register(
      email: email,
      password: password,
      displayName: displayName,
    );
  }
}
