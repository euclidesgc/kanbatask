import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../login/domain/repositories/auth_repository.dart';
import '../login/domain/use_cases/logout_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;
  final LogoutUseCase _logoutUseCase;
  StreamSubscription<User?>? _authSubscription;

  AuthCubit({
    required AuthRepository authRepository,
    required LogoutUseCase logoutUseCase,
  }) : _authRepository = authRepository,
       _logoutUseCase = logoutUseCase,
       super(AuthInitial()) {
    _initAuthState();
  }

  void _initAuthState() {
    emit(AuthInProgress());

    _authSubscription = _authRepository.authStateChanges.listen((user) {
      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthUnauthenticated());
      }
    });
  }

  Future<void> signOut() async {
    try {
      emit(AuthInProgress());
      await _logoutUseCase();
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }
}
