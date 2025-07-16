import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'app_routes.dart';
import 'modules/auth_module/cubit/auth_cubit.dart';
import 'modules/auth_module/login/data/datasources/auth_data_source.dart';
import 'modules/auth_module/login/data/repositories/auth_repository_impl.dart';
import 'modules/auth_module/login/domain/repositories/auth_repository.dart';
import 'modules/auth_module/login/domain/use_cases/login_usecase.dart';
import 'modules/auth_module/login/domain/use_cases/logout_usecase.dart';
import 'modules/auth_module/login/domain/use_cases/register_usecase.dart';

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

        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(
            authRepository: context.read<AuthRepository>(),
            logoutUseCase: context.read<LogoutUseCase>(),
          ),
        ),
      ],
      child: child,
    );
  }
}
