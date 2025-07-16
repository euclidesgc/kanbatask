import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../login/domain/use_cases/login_usecase.dart';
import '../../../session/domain/repositories/session_repository.dart';
import '../../../session/domain/use_cases/logout_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SessionRepository _sessionRepository;
  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;
  StreamSubscription<User?>? _authSubscription;

  AuthCubit({
    required SessionRepository sessionRepository,
    required LoginUseCase loginUseCase,
    required LogoutUseCase logoutUseCase,
  }) : _sessionRepository = sessionRepository,
       _loginUseCase = loginUseCase,
       _logoutUseCase = logoutUseCase,
       super(AuthInitial()) {
    _initAuthState();
  }

  void _initAuthState() {
    emit(AuthInProgress());

    _authSubscription = _sessionRepository.authStateChanges.listen((user) {
      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthUnauthenticated());
      }
    });
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      emit(AuthInProgress());
      await _loginUseCase(email: email, password: password);
      // O estado será atualizado automaticamente pelo _initAuthState
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
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
