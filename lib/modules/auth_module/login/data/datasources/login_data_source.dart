import 'package:firebase_auth/firebase_auth.dart';

import '../../../shared/data/models/user_model.dart';
import '../../../shared/data/utils/firebase_auth_error_handler.dart';

class LoginDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) {
        throw Exception('Login failed: User is null');
      }

      return UserModel.fromFirebaseUser(credential.user!);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthErrorHandler.handleException(e);
    } catch (e) {
      throw Exception('Unexpected error during login: $e');
    }
  }
}
