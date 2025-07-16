import 'package:firebase_auth/firebase_auth.dart';

import '../../../shared/data/utils/firebase_auth_error_handler.dart';

class ForgotPasswordDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> forgotPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthErrorHandler.handleException(e);
    } catch (e) {
      throw Exception('Unexpected error during password reset: $e');
    }
  }
}
