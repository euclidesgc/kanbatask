import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/use_cases/register_usecase.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase _registerUseCase;

  RegisterCubit({
    required RegisterUseCase registerUseCase,
  }) : _registerUseCase = registerUseCase,
       super(RegisterInitial());

  Future<void> register({
    required String email,
    required String password,
    String? displayName,
  }) async {
    try {
      emit(RegisterInProgress());
      await _registerUseCase(
        email: email,
        password: password,
        displayName: displayName,
      );
      emit(RegisterSuccess());
    } catch (e) {
      emit(RegisterFailure(e.toString()));
    }
  }
}
