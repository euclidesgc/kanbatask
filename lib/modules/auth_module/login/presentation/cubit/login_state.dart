import 'package:equatable/equatable.dart';

sealed class LoginState extends Equatable {
  const LoginState();
  @override
  List<Object?> get props => [];
}

final class LoginInitial extends LoginState {}

final class LoginLoadInProgress extends LoginState {}

final class LoginLoadSuccess extends LoginState {}

final class LoginLoadFailure extends LoginState {
  final String message;
  const LoginLoadFailure(this.message);
  @override
  List<Object?> get props => [message];
}
