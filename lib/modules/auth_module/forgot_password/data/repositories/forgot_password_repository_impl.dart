import '../../domain/repositories/forgot_password_repository.dart';
import '../datasources/forgot_password_data_source.dart';

class ForgotPasswordRepositoryImpl implements ForgotPasswordRepository {
  final ForgotPasswordDataSource _forgotPasswordDataSource;

  ForgotPasswordRepositoryImpl({
    required ForgotPasswordDataSource forgotPasswordDataSource,
  }) : _forgotPasswordDataSource = forgotPasswordDataSource;

  @override
  Future<void> forgotPassword(String email) async {
    await _forgotPasswordDataSource.forgotPassword(email);
  }
}
