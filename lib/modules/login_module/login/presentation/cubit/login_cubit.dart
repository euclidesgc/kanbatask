import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/use_cases/login_use_case.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;
  LoginCubit({required this.loginUseCase}) : super(LoginInitial());

  Future<void> submitLogin(String username, String password) async {
    emit(LoginLoadInProgress());
    try {
      // TODO: Chamar use case e emitir sucesso
      emit(LoginLoadSuccess());
    } catch (e) {
      emit(LoginLoadFailure(e.toString()));
    }
  }
}
