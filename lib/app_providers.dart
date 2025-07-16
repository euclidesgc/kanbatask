import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'app_routes.dart';
import 'modules/auth_module/cubit/auth_cubit.dart';
import 'modules/auth_module/forgot_password/data/datasources/forgot_password_data_source.dart';
import 'modules/auth_module/forgot_password/data/repositories/forgot_password_repository_impl.dart';
import 'modules/auth_module/forgot_password/domain/repositories/forgot_password_repository.dart';
import 'modules/auth_module/forgot_password/domain/use_cases/forgot_password_usecase.dart';
import 'modules/auth_module/forgot_password/presentation/pages/cubit/forgot_password_cubit.dart';
import 'modules/auth_module/login/data/datasources/auth_data_source.dart';
import 'modules/auth_module/login/data/repositories/auth_repository_impl.dart';
import 'modules/auth_module/login/domain/repositories/auth_repository.dart';
import 'modules/auth_module/login/domain/use_cases/login_usecase.dart';
import 'modules/auth_module/login/domain/use_cases/logout_usecase.dart';
import 'modules/auth_module/login/domain/use_cases/register_usecase.dart';
import 'modules/auth_module/register/presentation/cubit/register_cubit.dart';

class AppProviders extends StatelessWidget with AppRoutes {
  final Widget child;

  AppProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthDataSource>(
          create: (_) => AuthDataSource(),
        ),

        Provider<AuthRepository>(
          create: (context) => AuthRepositoryImpl(
            remoteDataSource: context.read<AuthDataSource>(),
          ),
        ),

        Provider<LoginUseCase>(
          create: (context) => LoginUseCase(
            context.read<AuthRepository>(),
          ),
        ),
        Provider<RegisterUseCase>(
          create: (context) => RegisterUseCase(
            context.read<AuthRepository>(),
          ),
        ),
        Provider<LogoutUseCase>(
          create: (context) => LogoutUseCase(
            context.read<AuthRepository>(),
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

        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(
            authRepository: context.read<AuthRepository>(),
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
