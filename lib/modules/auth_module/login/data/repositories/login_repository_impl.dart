import '../../../shared/domain/entities/user_entity.dart';
import '../../domain/repositories/login_repository.dart';
import '../datasources/login_data_source.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginDataSource _loginDataSource;

  LoginRepositoryImpl({
    required LoginDataSource loginDataSource,
  }) : _loginDataSource = loginDataSource;

  @override
  Future<UserEntity> login({
    required String email,
    required String password,
  }) async {
    final userModel = await _loginDataSource.login(
      email: email,
      password: password,
    );
    return userModel.toEntity();
  }
}
