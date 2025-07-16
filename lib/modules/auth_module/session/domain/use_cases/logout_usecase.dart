import '../repositories/session_repository.dart';

class LogoutUseCase {
  final SessionRepository _repository;

  LogoutUseCase(this._repository);

  Future<void> call() async {
    await _repository.logout();
  }
}
