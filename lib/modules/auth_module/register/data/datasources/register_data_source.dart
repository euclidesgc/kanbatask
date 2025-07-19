import 'package:firebase_auth/firebase_auth.dart';

import '../../../shared/data/models/user_model.dart';
import '../../../shared/data/utils/firebase_auth_error_handler.dart';

class RegisterDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserModel> register({
    required String email,
    required String password,
    String? displayName,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) {
        throw Exception('Registration failed: User is null');
      }

      if (displayName != null && displayName.isNotEmpty) {
        await credential.user!.updateDisplayName(displayName);
        await credential.user!.reload();
      }

      return UserModel.fromFirebaseUser(_auth.currentUser!);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthErrorHandler.handleException(e);
    } catch (e) {
      throw Exception('Unexpected error during registration: $e');
    }
  }
}
