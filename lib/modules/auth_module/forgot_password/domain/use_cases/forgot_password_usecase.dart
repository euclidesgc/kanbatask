import '../repositories/forgot_password_repository.dart';

class ForgotPasswordUseCase {
  final ForgotPasswordRepository _repository;

  ForgotPasswordUseCase(this._repository);

  Future<void> call({required String email}) async {
    return await _repository.forgotPassword(email);
  }
}
