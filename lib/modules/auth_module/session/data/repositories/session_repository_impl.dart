import 'package:firebase_auth/firebase_auth.dart';

import '../../data/datasources/session_data_source.dart';
import '../../domain/repositories/session_repository.dart';

class SessionRepositoryImpl implements SessionRepository {
  final SessionDataSource _sessionDataSource;

  SessionRepositoryImpl({
    required SessionDataSource sessionDataSource,
  }) : _sessionDataSource = sessionDataSource;

  @override
  Stream<User?> get authStateChanges => _sessionDataSource.authStateChanges;

  @override
  User? get currentUser => _sessionDataSource.currentUser;

  @override
  Future<void> logout() async {
    await _sessionDataSource.logout();
  }
}
