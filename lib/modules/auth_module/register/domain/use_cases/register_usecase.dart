import '../../../shared/domain/entities/user_entity.dart';
import '../repositories/register_repository.dart';

class RegisterUseCase {
  final RegisterRepository _repository;

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
