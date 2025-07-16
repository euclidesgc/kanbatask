import '../../../shared/domain/entities/user_entity.dart';

abstract class LoginRepository {
  Future<UserEntity> login({
    required String email,
    required String password,
  });
}
