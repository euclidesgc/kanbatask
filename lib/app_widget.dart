import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'app_routes.dart';
import 'modules/auth_module/cubit/auth_cubit.dart';

class AppWidget extends StatelessWidget with AppRoutes {
  AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'KanbaTask',
      debugShowCheckedModeBanner: false,
      routerConfig: appRoutes,
      builder: (context, child) {
        return BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            switch (state) {
              case AuthAuthenticated():
                context.go('/home');
              case AuthUnauthenticated():
                context.go('/login');
              case AuthFailure():
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
              case AuthInProgress():
              case AuthInitial():
                break;
            }
          },
          child: child!,
        );
      },
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
    );
  }
}
