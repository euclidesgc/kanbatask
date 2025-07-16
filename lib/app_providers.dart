import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'modules/auth_module/forgot_password/data/datasources/forgot_password_data_source.dart';
import 'modules/auth_module/forgot_password/data/repositories/forgot_password_repository_impl.dart';
import 'modules/auth_module/forgot_password/domain/repositories/forgot_password_repository.dart';
import 'modules/auth_module/forgot_password/domain/use_cases/forgot_password_usecase.dart';
import 'modules/auth_module/forgot_password/presentation/pages/cubit/forgot_password_cubit.dart';
import 'modules/auth_module/login/data/datasources/login_data_source.dart';
import 'modules/auth_module/login/data/repositories/login_repository_impl.dart';
import 'modules/auth_module/login/domain/repositories/login_repository.dart';
import 'modules/auth_module/login/domain/use_cases/login_usecase.dart';
import 'modules/auth_module/register/data/datasources/register_data_source.dart';
import 'modules/auth_module/register/data/repositories/register_repository_impl.dart';
import 'modules/auth_module/register/domain/repositories/register_repository.dart';
import 'modules/auth_module/register/domain/use_cases/register_usecase.dart';
import 'modules/auth_module/register/presentation/cubit/register_cubit.dart';
import 'modules/auth_module/session/data/datasources/session_data_source.dart';
import 'modules/auth_module/session/data/repositories/session_repository_impl.dart';
import 'modules/auth_module/session/domain/repositories/session_repository.dart';
import 'modules/auth_module/session/domain/use_cases/logout_usecase.dart';
import 'modules/auth_module/shared/presentation/cubits/auth_cubit.dart';

class AppProviders extends StatelessWidget {
  final Widget child;

  const AppProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Session providers
        Provider<SessionDataSource>(
          create: (_) => SessionDataSource(),
        ),
        Provider<SessionRepository>(
          create: (context) => SessionRepositoryImpl(
            sessionDataSource: context.read<SessionDataSource>(),
          ),
        ),

        // Login providers
        Provider<LoginDataSource>(
          create: (_) => LoginDataSource(),
        ),
        Provider<LoginRepository>(
          create: (context) => LoginRepositoryImpl(
            loginDataSource: context.read<LoginDataSource>(),
          ),
        ),
        Provider<LoginUseCase>(
          create: (context) => LoginUseCase(
            context.read<LoginRepository>(),
          ),
        ),

        // Register providers
        Provider<RegisterDataSource>(
          create: (_) => RegisterDataSource(),
        ),
        Provider<RegisterRepository>(
          create: (context) => RegisterRepositoryImpl(
            registerDataSource: context.read<RegisterDataSource>(),
          ),
        ),
        Provider<RegisterUseCase>(
          create: (context) => RegisterUseCase(
            context.read<RegisterRepository>(),
          ),
        ),

        // Logout use case
        Provider<LogoutUseCase>(
          create: (context) => LogoutUseCase(
            context.read<SessionRepository>(),
          ),
        ),

        // ForgotPassword providers
        Provider<ForgotPasswordDataSource>(
          create: (_) => ForgotPasswordDataSource(),
        ),
        Provider<ForgotPasswordRepository>(
          create: (context) => ForgotPasswordRepositoryImpl(
            forgotPasswordDataSource: context.read<ForgotPasswordDataSource>(),
          ),
        ),
        Provider<ForgotPasswordUseCase>(
          create: (context) => ForgotPasswordUseCase(
            context.read<ForgotPasswordRepository>(),
          ),
        ),

        // Cubits
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(
            sessionRepository: context.read<SessionRepository>(),
            loginUseCase: context.read<LoginUseCase>(),
            logoutUseCase: context.read<LogoutUseCase>(),
          ),
        ),
        BlocProvider<RegisterCubit>(
          create: (context) => RegisterCubit(
            registerUseCase: context.read<RegisterUseCase>(),
          ),
        ),
        BlocProvider<ForgotPasswordCubit>(
          create: (context) => ForgotPasswordCubit(
            context.read<ForgotPasswordUseCase>(),
          ),
        ),
      ],
      child: child,
    );
  }
}
