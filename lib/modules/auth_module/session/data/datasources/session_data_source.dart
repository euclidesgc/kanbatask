import 'package:firebase_auth/firebase_auth.dart';

import '../../../shared/data/utils/firebase_auth_error_handler.dart';

class SessionDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  User? get currentUser => _auth.currentUser;

  Future<void> logout() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthErrorHandler.handleException(e);
    } catch (e) {
      throw Exception('Unexpected error during logout: $e');
    }
  }
}
