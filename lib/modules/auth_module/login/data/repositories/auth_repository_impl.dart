import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _remoteDataSource;

  AuthRepositoryImpl({
    required AuthDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Stream<User?> get authStateChanges => _remoteDataSource.authStateChanges;

  @override
  User? get currentUser => _remoteDataSource.currentUser;

  @override
  Future<UserEntity> login({
    required String email,
    required String password,
  }) async {
    final userModel = await _remoteDataSource.login(
      email: email,
      password: password,
    );
    return userModel.toEntity();
  }

  @override
  Future<UserEntity> register({
    required String email,
    required String password,
    String? displayName,
  }) async {
    final userModel = await _remoteDataSource.register(
      email: email,
      password: password,
      displayName: displayName,
    );
    return userModel.toEntity();
  }

  @override
  Future<void> logout() async {
    await _remoteDataSource.logout();
  }

  @override
  Future<void> forgotPassword(String email) async {
    await _remoteDataSource.forgotPassword(email);
  }
}
