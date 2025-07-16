import 'package:firebase_auth/firebase_auth.dart';

import '../entities/user_entity.dart';

abstract class AuthRepository {
  Stream<User?> get authStateChanges;

  Future<UserEntity> login({
    required String email,
    required String password,
  });

  Future<UserEntity> register({
    required String email,
    required String password,
    String? displayName,
  });

  Future<void> logout();

  Future<void> forgotPassword(String email);

  User? get currentUser;
}
