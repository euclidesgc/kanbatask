import 'package:firebase_auth/firebase_auth.dart';

abstract class SessionRepository {
  Stream<User?> get authStateChanges;
  User? get currentUser;
  Future<void> logout();
}
