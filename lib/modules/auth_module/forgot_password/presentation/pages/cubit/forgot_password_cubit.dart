import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kanbatask/modules/auth_module/forgot_password/domain/use_cases/forgot_password_usecase.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final ForgotPasswordUseCase _forgotPasswordUseCase;

  ForgotPasswordCubit(this._forgotPasswordUseCase)
    : super(ForgotPasswordInitial());

  Future<void> forgotPassword({
    required String email,
  }) async {
    try {
      emit(ForgotPasswordInProgress());
      await _forgotPasswordUseCase(email: email);
      emit(ForgotPasswordSuccess());
    } catch (e) {
      emit(ForgotPasswordFailure(e.toString()));
    }
  }
}
