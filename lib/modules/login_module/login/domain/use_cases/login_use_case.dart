import '../../data/repository/login_repository_impl.dart';
import '../entities/user_entity.dart';

class LoginUseCase {
  final LoginRepositoryImpl repository;
  LoginUseCase({required this.repository});

  Future<UserEntity> call(String username, String password) async {
    // TODO: Implementar chamada ao repositório
    throw UnimplementedError();
  }
}
