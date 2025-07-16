import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanbatask/modules/auth_module/login/domain/use_cases/login_usecase.dart';

import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;
  LoginCubit({required this.loginUseCase}) : super(LoginInitial());

  Future<void> submitLogin(String username, String password) async {
    emit(LoginLoadInProgress());
    try {
      emit(LoginLoadSuccess());
    } catch (e) {
      emit(LoginLoadFailure(e.toString()));
    }
  }
}
