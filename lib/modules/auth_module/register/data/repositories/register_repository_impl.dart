import '../../../shared/domain/entities/user_entity.dart';
import '../../domain/repositories/register_repository.dart';
import '../datasources/register_data_source.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final RegisterDataSource _registerDataSource;

  RegisterRepositoryImpl({
    required RegisterDataSource registerDataSource,
  }) : _registerDataSource = registerDataSource;

  @override
  Future<UserEntity> register({
    required String email,
    required String password,
    String? displayName,
  }) async {
    final userModel = await _registerDataSource.register(
      email: email,
      password: password,
      displayName: displayName,
    );
    return userModel.toEntity();
  }
}
